
Given /^a bucket containing the test request$/ do
  step "no pairs"
  step "the test request is performed"
end

When /^the bucket is cleared$/ do
  delete "/_control/bucket"
end

Then /^the bucket should be empty$/ do
  get "/_control/bucket"
  last_response_status.should == 200
  last_json_response_body.should == [ ]
end

Then /^the bucket should contain the test request$/ do
  get "/_control/bucket"
  last_json_response_body.detect do |request|
    request["method"] == "GET" && request["path"] == "/test-request"
  end.should_not be_nil
end
