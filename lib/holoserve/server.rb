require 'rack/builder'

require File.expand_path(File.join(File.dirname(__FILE__), "..", "holoserve"))

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
    @configuration = Holoserve::Configuration.new
  end

  def initialize_bucket
    @bucket = Holoserve::Bucket.new
  end

  def initialize_history
    @history = Holoserve::History.new
  end

  def initialize_rack
    @rack = Rack::Builder.new do
      use Holoserve::Interface::Control
      run Holoserve::Interface::Fake.new
    end
  end

  def self.instance
    @instance ||= self.new
  end

end
