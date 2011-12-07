require 'rack/builder'
require File.join(File.dirname(__FILE__), "configuration")

class Application

  attr_reader :configuration
  attr_reader :rack

  def initialize
    initialize_configuration
    initialize_rack
  end

  private

  def initialize_configuration
    @configuration = Configuration.new
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
