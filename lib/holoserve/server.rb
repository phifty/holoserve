require 'rack/builder'

require File.join(File.dirname(__FILE__), "..", "bucket")
require File.join(File.dirname(__FILE__), "..", "configuration")
require File.join(File.dirname(__FILE__), "..", "history")
require File.join(File.dirname(__FILE__), "..", "holoserve")
require File.join(File.dirname(__FILE__), "..", "interface")
require File.join(File.dirname(__FILE__), "..", "pair")
require File.join(File.dirname(__FILE__), "..", "request")
require File.join(File.dirname(__FILE__), "..", "response")
require File.join(File.dirname(__FILE__), "..", "tool")

class Holoserve::Server

  autoload :Runner, File.join(File.dirname(__FILE__), "server", "runner")

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
