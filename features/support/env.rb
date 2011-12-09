require 'rubygems'
require 'bundler/setup'
require 'cucumber/formatter/unicode'
require 'rspec/expectations'
require 'json'
require 'transport'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "holoserve", "server"))

class TestWorld

  attr_reader :server

  attr_reader :last_response_status
  attr_reader :last_response_body

  def initialize
    @server = Holoserve::Server::Runner.new
  end

  def post_yml(path, filename)
    boundary = "xxx12345xxx"
    perform "method" => "POST",
            "path" => path,
            "headers" => {
              "Content-Type" => "multipart/form-data, boundary=#{boundary}"
            },
            "body" =>
              "--#{boundary}\r\n" +
              "Content-Disposition: form-data; name=\"file\"; filename=\"#{File.basename(filename)}\"\r\n" +
              "Content-Type: application/x-yaml\r\n" +
              "\r\n" +
              File.read(filename) +
              "\r\n" +
              "--#{boundary}--\r\n"
  end

  def post(path, parameters = { }, headers = { })
    perform "method" => "POST", "path" => path, "parameters" => parameters, "headers" => headers
  end

  def put(path, parameters = { }, headers = { })
    perform "method" => "PUT", "path" => path, "parameters" => parameters, "headers" => headers
  end

  def get(path, parameters = { }, headers = { })
    perform "method" => "GET", "path" => path, "parameters" => parameters, "headers" => headers
  end

  def delete(path, parameters = { }, headers = { })
    perform "method" => "DELETE", "path" => path, "parameters" => parameters, "headers" => headers
  end

  def perform(request)
    @last_response_status = 200
    @last_response_body = Transport::HTTP.request :"#{request["method"].downcase}",
                                                  "http://localhost:8080#{request["path"]}",
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
