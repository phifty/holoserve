require 'rack/builder'
require File.join(File.dirname(__FILE__), "configuration")

class Application

  module Interface

    autoload :Control, File.join(File.dirname(__FILE__), "interface", "control")
    autoload :Face, File.join(File.dirname(__FILE__), "interface", "face")

  end

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
      run Interface::Face.new
    end
  end

  def self.instance
    @instance ||= self.new
  end

end
