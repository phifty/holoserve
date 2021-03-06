require 'rubygems'
require 'bundler/setup'
require 'cucumber/formatter/unicode'
require 'rspec/expectations'
require 'json'
require 'transport'
require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "holoserve"))

class TestWorld

  attr_reader :last_response_status
  attr_reader :last_response_body

  def post(path, parameters = { }, headers = { })
    perform "method" => "POST",
            "path" => path,
            "body" => URI.encode_www_form(parameters),
            "headers" => headers.merge("Content-Type" => "application/x-www-form-urlencoded")
  end

  def post_json(path, hash = { })
    perform "method" => "POST",
            "path" => path,
            "body" => JSON.dump(hash),
            "headers" => { "Content-Type" => "application/json" }
  end

  def put(path, parameters = { }, headers = { })
    perform "method" => "PUT",
            "path" => path,
            "body" => URI.encode_www_form(parameters),
            "headers" => headers.merge("Content-Type" => "application/x-www-form-urlencoded")
  end

  def get(path, parameters = { }, headers = { }, body = nil)
    perform "method" => "GET",
            "path" => path,
            "parameters" => parameters,
            "headers" => headers,
            "body" => body
  end

  def delete(path, parameters = { }, headers = { })
    perform "method" => "DELETE",
            "path" => path,
            "body" => URI.encode_www_form(parameters),
            "headers" => headers.merge("Content-Type" => "application/x-www-form-urlencoded")
  end

  def perform(request)
    @last_response_status = 200
    @last_response_body = Transport::HTTP.request :"#{request["method"].downcase}",
                                                  "http://localhost:4250#{request["path"]}",
                                                  :headers => request["headers"],
                                                  :body => request["body"],
                                                  :parameters => request["parameters"],
                                                  :expected_status_code => 200
  rescue Transport::UnexpectedStatusCodeError => error
    @last_response_status = error.status_code
    @last_response_body = error.message
  end

  def last_json_response_body
    JSON.parse last_response_body
  end

end

test_world = TestWorld.new
World { test_world }
