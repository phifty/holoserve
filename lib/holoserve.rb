require 'goliath/runner'
require 'logger'

class Holoserve

  autoload :Fixture, File.join(File.dirname(__FILE__), "holoserve", "fixture")
  autoload :Interface, File.join(File.dirname(__FILE__), "holoserve", "interface")
  autoload :Loader, File.join(File.dirname(__FILE__), "holoserve", "loader")
  autoload :Pair, File.join(File.dirname(__FILE__), "holoserve", "pair")
  autoload :Request, File.join(File.dirname(__FILE__), "holoserve", "request")
  autoload :Response, File.join(File.dirname(__FILE__), "holoserve", "response")
  autoload :Runner, File.join(File.dirname(__FILE__), "holoserve", "runner")
  autoload :Tool, File.join(File.dirname(__FILE__), "holoserve", "tool")

  attr_reader :logger
  attr_reader :configuration

  def initialize(options = { })
    @port = options[:port] || 4250
    @environment = options[:environment] || "development"
    @pid_filename = options[:pid_filename] || File.expand_path(File.join(File.dirname(__FILE__), "..", "holoserve_#{@environment}.pid"))
    @log_filename = options[:log_filename] || File.expand_path(File.join(File.dirname(__FILE__), "..", "holoserve_#{@environment}.log"))
    @fixture_file_pattern = options[:fixture_file_pattern]
    @pair_file_pattern = options[:pair_file_pattern]
    @situation = options[:situation]

    load_configuration
  end

  def start
    run_goliath true
  end

  def run
    run_goliath false
  end

  def stop
    kill_goliath
  end

  private

  def load_configuration
    @configuration = Loader.new(@fixture_file_pattern, @pair_file_pattern).configuration
    @configuration[:situation] = @situation
  end

  def run_goliath(daemonize)
    runner = Goliath::Runner.new [
      "-v",
      "-P", @pid_filename,
      "-l", @log_filename,
      "-e", @environment,
      "-p", @port.to_s,
      daemonize ? "-d" : "-s"
    ], nil
    runner.options[:fixtures] = @configuration[:fixtures]
    runner.options[:pairs] = @configuration[:pairs]
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

  def self.instance(options = { })
    @instance ||= self.new options
  end

end
