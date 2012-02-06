
Then /^the test response should be returned/ do
  last_response_status.should == 200
  last_response_body.should == "test_request"
end

Then /^the test parameters response should be returned/ do
  last_response_status.should == 200
  last_response_body.should == "test_parameters"
end

Then /^the test headers response should be returned/ do
  last_response_status.should == 200
  last_response_body.should == "test_headers"
end

Then /^the test json response should be returned/ do
  last_response_status.should == 200
  last_json_response_body.should == { "test" => "value" }
end

Then /^the test oauth response should be returned/ do
  last_response_status.should == 200
  last_response_body.should == "test_oauth"
end

Then /^the test response default should be returned/ do
  last_response_status.should == 200
  last_response_body.should == ""
end
