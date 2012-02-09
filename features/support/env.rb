require 'rubygems'
require 'bundler/setup'
require 'cucumber/formatter/unicode'
require 'rspec/expectations'
require 'json'
require 'transport'
require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "holoserve"))

class TestWorld

  attr_reader :port
  attr_reader :server

  attr_reader :last_response_status
  attr_reader :last_response_body

  def initialize
    @port = 4250
    @server = Holoserve::Runner.new :port => @port,
                                    :fixture_file_pattern => File.expand_path(File.join(File.dirname(__FILE__), "..", "fixtures", "test_*.yaml")),
                                    :pair_file_pattern => File.expand_path(File.join(File.dirname(__FILE__), "..", "pairs", "test_*.yaml"))
  end

  def post_file(path, filename)
    @last_response_status = 200
    @last_response_body = Holoserve::Tool::Uploader.new(
      filename,
      :post,
      "http://localhost:#{port}#{path}",
      :expected_status_code => 200
    ).upload
  rescue Transport::UnexpectedStatusCodeError => error
    @last_response_status = error.status_code
    @last_response_body = error.message
  end

  def post(path, parameters = { }, headers = { })
    perform "method" => "POST",
            "path" => path,
            "body" => URI.encode_www_form(parameters),
            "headers" => headers.merge("Content-Type" => "application/x-www-form-urlencoded")
  end

  def put(path, parameters = { }, headers = { })
    perform "method" => "PUT",
            "path" => path,
            "body" => URI.encode_www_form(parameters),
            "headers" => headers.merge("Content-Type" => "application/x-www-form-urlencoded")
  end

  def get(path, parameters = { }, headers = { })
    perform "method" => "GET",
            "path" => path,
            "parameters" => parameters,
            "headers" => headers
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
                                                  "http://localhost:#{port}#{request["path"]}",
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
test_world.server.start

World { test_world }

at_exit do
  test_world.server.stop
end
