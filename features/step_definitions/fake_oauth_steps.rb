require 'oauth'

Given /^the test oauth consumer$/ do
  @consumer = OAuth::Consumer.new "consumer_id",
                                  "consumer_secret",
                                  :site => "http://localhost:#{port}"
end

When /^the request token is requested$/ do
  @request_token = @consumer.get_request_token
end

When /^the access token is requested$/ do
  @access_token = @request_token.get_access_token
end

When /^the oauth test get request is performed$/ do
  @access_token.get "/test"
end
