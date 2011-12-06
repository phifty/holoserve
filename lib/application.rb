require 'rack/builder'

class Application

  module Rack

    autoload :Control, File.join(File.dirname(__FILE__), "rack", "control")
    autoload :Face, File.join(File.dirname(__FILE__), "rack", "face")

  end

  attr_reader :rack

  def initialize
    initialize_rack
  end

  private

  def initialize_rack
    @rack = ::Rack::Builder.new do
      use Rack::Control
      run Rack::Face
    end
  end

end