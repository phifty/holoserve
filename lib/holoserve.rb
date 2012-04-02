require 'goliath/runner'
require 'logger'

class Holoserve

  autoload :Fixture, File.join(File.dirname(__FILE__), "holoserve", "fixture")
  autoload :Interface, File.join(File.dirname(__FILE__), "holoserve", "interface")
  autoload :Pair, File.join(File.dirname(__FILE__), "holoserve", "pair")
  autoload :Request, File.join(File.dirname(__FILE__), "holoserve", "request")
  autoload :Response, File.join(File.dirname(__FILE__), "holoserve", "response")
  autoload :State, File.join(File.dirname(__FILE__), "holoserve", "state")
  autoload :Tool, File.join(File.dirname(__FILE__), "holoserve", "tool")

  def initialize(options = { })
    @port = options[:port] || 4250
    @pid_filename = options[:pid_filename] || File.expand_path(File.join(File.dirname(__FILE__), "..", "holoserve.pid"))
    @log_filename = options[:log_filename] || File.expand_path(File.join(File.dirname(__FILE__), "..", "holoserve.log"))
    @fixture_file_pattern = options[:fixture_file_pattern]
    @pair_file_pattern = options[:pair_file_pattern]
    @state = options[:state] || { }
  end

  def start
    initialize_logger
    load_pairs
    run_goliath true
    wait_until_running
  end

  def run
    initialize_logger
    load_pairs
    run_goliath false
  end

  def stop
    kill_goliath
  end

  def running?
    !!(process_id && Process.kill(0, process_id) == 1)
  rescue Errno::ESRCH
    false
  end

  def process_id
    File.read(@pid_filename).to_i
  rescue Errno::ENOENT
    nil
  end

  private

  def initialize_logger
    @logger = Logger.new @log_filename
  end

  def load_pairs
    @pairs = Pair::Loader.new(@fixture_file_pattern, @pair_file_pattern, @logger).pairs
  end

  def run_goliath(daemonize)
    saved_directory = Dir.pwd

    runner = Goliath::Runner.new [
      "-P", @pid_filename,
      "-l", @log_filename,
      "-e", "production",
      "-p", @port.to_s,
      daemonize ? "-d" : "-s"
    ], nil
    runner.options[:pairs] = @pairs
    runner.options[:state] = Tool::Hash::KeySymbolizer.new(@state).hash
    runner.api = Interface.new
    runner.app = Goliath::Rack::Builder.build Interface, runner.api
    runner.run

    Dir.chdir saved_directory
  end

  def wait_until_running
    sleep 0.2 while !self.running?
  end

  def kill_goliath
    if File.exists?(@pid_filename)
      system "kill -s QUIT `cat #{@pid_filename}`"
      File.delete @pid_filename
    end
  end

end
