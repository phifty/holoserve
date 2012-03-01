require 'goliath/runner'
require 'pp'

class Holoserve

  autoload :Fixture, File.join(File.dirname(__FILE__), "holoserve", "fixture")
  autoload :Interface, File.join(File.dirname(__FILE__), "holoserve", "interface")
  autoload :Pair, File.join(File.dirname(__FILE__), "holoserve", "pair")
  autoload :Request, File.join(File.dirname(__FILE__), "holoserve", "request")
  autoload :Response, File.join(File.dirname(__FILE__), "holoserve", "response")
  autoload :Runner, File.join(File.dirname(__FILE__), "holoserve", "runner")
  autoload :Tool, File.join(File.dirname(__FILE__), "holoserve", "tool")

  def initialize(options = { })
    @port = options[:port] || 4250
    @environment = options[:environment] || "development"
    @pid_filename = options[:pid_filename] || File.expand_path(File.join(File.dirname(__FILE__), "..", "holoserve_#{@environment}.pid"))
    @log_filename = options[:log_filename] || File.expand_path(File.join(File.dirname(__FILE__), "..", "holoserve_#{@environment}.log"))
    @fixture_file_pattern = options[:fixture_file_pattern]
    @pair_file_pattern = options[:pair_file_pattern]
    @situation = options[:situation]
  end

  def start
    load_pairs
    run_goliath true
  end

  def run
    load_pairs
    run_goliath false
  end

  def stop
    kill_goliath
  end

  private

  def load_pairs
    @pairs = Pair::Loader.new(@fixture_file_pattern, @pair_file_pattern).pairs
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
    runner.options[:pairs] = @pairs
    runner.options[:situation] = @situation
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
