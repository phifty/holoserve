require 'rubygems'
require 'bundler/setup'
require 'cucumber/formatter/unicode'
require 'rspec/expectations'
require 'rack/test'
require 'json'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "holoserve"))

class TestWorld
  include Rack::Test::Methods

  def app
    Application.instance.rack
  end

  def last_json_response_body
    JSON.parse last_response.body
  end

end

World { TestWorld.new }
