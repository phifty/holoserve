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

  def perform(request)
    send :"perform_#{request["method"].downcase}", request
  end

  def last_json_response_body
    JSON.parse last_response.body
  end

  private

  def perform_post(request)
    post request["path"]
  end

  def perform_put(request)
    put request["path"]
  end

  def perform_get(request)
    get request["path"]
  end

  def perform_delete(request)
    delete request["path"]
  end

end

World { TestWorld.new }
