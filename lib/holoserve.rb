require 'goliath/runner'
require 'logger'

class Holoserve

  autoload :Fixture, File.join(File.dirname(__FILE__), "holoserve", "fixture")
  autoload :Interface, File.join(File.dirname(__FILE__), "holoserve", "interface")
  autoload :Pair, File.join(File.dirname(__FILE__), "holoserve", "pair")
  autoload :Request, File.join(File.dirname(__FILE__), "holoserve", "request")
  autoload :Response, File.join(File.dirname(__FILE__), "holoserve", "response")
  autoload :Runner, File.join(File.dirname(__FILE__), "holoserve", "runner")
  autoload :Tool, File.join(File.dirname(__FILE__), "holoserve", "tool")

  attr_accessor :port
  attr_accessor :environment
  attr_accessor :pid_filename
  attr_accessor :log_filename
  attr_accessor :fixture_file_pattern
  attr_accessor :pair_file_pattern
  attr_accessor :situation

  def initialize(options = { })
    @port = options[:port] || 4250
    @environment = options[:environment] || "development"
    @pid_filename = options[:pid_filename] || File.expand_path(File.join(File.dirname(__FILE__), "..", "holoserve_#{@environment}.pid"))
    @log_filename = options[:log_filename] || File.expand_path(File.join(File.dirname(__FILE__), "..", "holoserve_#{@environment}.log"))
    @fixture_file_pattern = options[:fixture_file_pattern]
    @pair_file_pattern = options[:pair_file_pattern]
    @state = options[:state]
  end

  def start
    initialize_logger
    load_pairs
    run_goliath true
  end

  def run
    initialize_logger
    load_pairs
    run_goliath false
  end

  def stop
    kill_goliath
  end

  private

  def initialize_logger
    @logger = Logger.new @log_filename
  end

  def load_pairs
    @pairs = Pair::Loader.new(@fixture_file_pattern, @pair_file_pattern, @logger).pairs
  end

  def run_goliath(daemonize)
    runner = Goliath::Runner.new [
      "-P", @pid_filename,
      "-l", @log_filename,
      "-e", @environment,
      "-p", @port.to_s,
      daemonize ? "-d" : "-s"
    ], nil
    runner.options[:pairs] = @pairs
    runner.options[:state] = @state
    runner.api = Interface.new
    runner.app = Goliath::Rack::Builder.build Interface, runner.api
    runner.run
  end

  def kill_goliath
    if File.exists?(@pid_filename)
      system "kill -s QUIT `cat #{@pid_filename}`"
      File.delete @pid_filename
    end
  end

end
