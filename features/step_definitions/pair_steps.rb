
Given /^no pairs$/ do
  delete "/_control/pairs"
end

Given /^the test pairs$/ do
  step "the yaml pairs are added"
end

When /^the (yaml|json|invalid) pairs are added$/ do |format|
  Dir[ File.join(File.dirname(__FILE__), "..", "pairs", "test_*.#{format}") ].each do |filename|
    post_file "/_control/pairs", filename
  end
end

Then /^the test pair should be present$/ do
  get "/_control/pairs/test_request.json"
  last_response_status.should == 200
end

Then /^the test pair should be absent$/ do
  get "/_control/pairs/test_request.json"
  last_response_status.should == 404
end

Then /the list of pairs should contain the test pair/ do
  get "/_control/pairs.json"
  last_json_response_body.keys.should include("test_request")
end

Then /^the list of evaluated pairs should contain the evaluated test parameters pair$/ do
  get "/_control/pairs.json", :evaluate => true
  response = last_json_response_body
  response.keys.should include("test_parameters")
  response["test_parameters"].should == {
    "request" => {
      "method" => "GET",
      "path" => "/test-parameters",
      "parameters" => { "test" => "value" }
    },
    "responses" => {
      "default" => {
        "status" => 200,
        "body" => "test_parameters"
      }
    }
  }
end

Then /^the test evaluation pair should be evaluated$/ do
  get "/_control/pairs/test_evaluation.json", :evaluate => true
  response = last_json_response_body
  response.should == {
    "request" => {
      "method" => "GET",
      "path" => "/test-evaluation",
      "parameters" => { "test" => "value", "another" => "value" }
    },
    "responses" => {
      "default" => {
        "status" => 200,
        "body" => "test_evaluation"
      }
    }
  }
end
