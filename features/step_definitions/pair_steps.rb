
When /^the list of pairs is fetched$/ do
  get "/_control/pairs"
end

When /^the pair of the test request is fetched$/ do
  get "/_control/pairs/test_request"
end

When /^the pair of the test evaluation request is fetched$/ do
  get "/_control/pairs/test_evaluation"
end

Then /^the returned list should contain the pair of the test request$/ do
  last_response_status.should == 200
  last_json_response_body.keys.should include("test_request")
end

Then /^the returned pair should contain the test request$/ do
  last_response_status.should == 200
  last_json_response_body.should == {
    "request" => {
      "method" => "GET",
      "path" => "/test-request"
    },
    "responses" => {
      "default" => {
        "status" => 200
      },
      "one" => {
        "body" => "test_request"
      }
    }
  }
end

Then /^the returned pair should contain the test evaluation request$/ do
  last_response_status.should == 200
  last_json_response_body.should == {
    "request" => {
      "method" => "GET",
      "path" => "/test-evaluation",
      "parameters" => {
        "test" => "value",
        "another" => "value"
      }
    },
    "responses" => {
      "default" => {
        "status" => 200,
        "body" => "test_evaluation"
      }
    }
  }
end
