
Given /^no fixtures$/ do
  delete "/_control/fixtures"
end

When /^the (yaml|json|invalid) fixtures are added$/ do |format|
  Dir[ File.join(File.dirname(__FILE__), "..", "fixtures", "test_*.#{format}") ].each do |filename|
    post_file "/_control/fixtures", filename, {
      "yaml" => "application/x-yaml",
      "json" => "application/json",
      "invalid" => "application/x-yaml"
    }[format]
  end
end

Then /^the test fixture should be present$/ do
  get "/_control/fixtures/test_fixture.json"
  last_response_status.should == 200
end

Then /^the test fixture should be absent$/ do
  get "/_control/fixtures/test_fixture.json"
  last_response_status.should == 404
end
