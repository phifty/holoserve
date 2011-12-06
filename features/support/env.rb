require 'rubygems'
require 'bundler/setup'
require 'cucumber/formatter/unicode'
require 'rspec/expectations'
require 'rack/test'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "application"))

class TestWorld
  include Rack::Test::Methods

  def app
    @application ||= Application.new
    @application.rack
  end

end

World { TestWorld.new }
