require 'rack/builder'
require 'logger'

class Holoserve

  autoload :Fixture, File.join(File.dirname(__FILE__), "holoserve", "fixture")
  autoload :Interface, File.join(File.dirname(__FILE__), "holoserve", "interface")
  autoload :Pair, File.join(File.dirname(__FILE__), "holoserve", "pair")
  autoload :Request, File.join(File.dirname(__FILE__), "holoserve", "request")
  autoload :Response, File.join(File.dirname(__FILE__), "holoserve", "response")
  autoload :Runner, File.join(File.dirname(__FILE__), "holoserve", "runner")
  autoload :Tool, File.join(File.dirname(__FILE__), "holoserve", "tool")

  attr_reader :logger
  attr_reader :configuration
  attr_reader :rack

  def initialize
    initialize_logger
    initialize_configuration
    initialize_rack
  end

  private

  def initialize_logger
    @logger = Logger.new STDOUT
  end

  def initialize_configuration
    @configuration = {
      :pairs => { },
      :fixtures => { },
      :situation => nil,
      :bucket => [ ],
      :history => [ ]
    }
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
