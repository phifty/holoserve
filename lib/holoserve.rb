require 'rack/builder'

class Holoserve

  autoload :Bucket, File.join(File.dirname(__FILE__), "holoserve", "bucket")
  autoload :Configuration, File.join(File.dirname(__FILE__), "holoserve", "configuration")
  autoload :History, File.join(File.dirname(__FILE__), "holoserve", "history")
  autoload :Interface, File.join(File.dirname(__FILE__), "holoserve", "interface")
  autoload :Pair, File.join(File.dirname(__FILE__), "holoserve", "pair")
  autoload :Request, File.join(File.dirname(__FILE__), "holoserve", "request")
  autoload :Response, File.join(File.dirname(__FILE__), "holoserve", "response")
  autoload :Runner, File.join(File.dirname(__FILE__), "holoserve", "runner")
  autoload :Tool, File.join(File.dirname(__FILE__), "holoserve", "tool")

  attr_reader :configuration
  attr_reader :bucket
  attr_reader :history
  attr_reader :rack

  def initialize
    initialize_configuration
    initialize_bucket
    initialize_history
    initialize_rack
  end

  private

  def initialize_configuration
    @configuration = Configuration.new
  end

  def initialize_bucket
    @bucket = Bucket.new
  end

  def initialize_history
    @history = History.new
  end

  def initialize_rack
    @rack = Rack::Builder.new do
      use Interface::Control
      run Interface::Fake.new
    end
  end

  def self.instance
    @instance ||= self.new
  end

end
