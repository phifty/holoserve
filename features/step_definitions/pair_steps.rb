
Given /^no pairs$/ do
  delete "/_control/pairs"
end

Given /^the test pairs$/ do
  step "the yaml pairs are added"
end

When /^the (yaml|json|invalid) pairs are added$/ do |format|
  Dir[ File.join(File.dirname(__FILE__), "..", "pairs", "test_*.#{format}") ].each do |filename|
    post_file "/_control/pairs", filename, {
      "yaml" => "application/x-yaml",
      "json" => "application/json",
      "invalid" => "application/x-yaml"
    }[format]
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
