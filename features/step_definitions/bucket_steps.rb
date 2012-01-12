
Then /^the bucket should contain the (.+)$/ do |request|
  get "/_control/bucket/requests"
  last_json_response_body.inject true do |result, request_in_bucket|
    result && Holoserve::Request::Matcher.new(request_in_bucket, request).match?
  end.should be_true
end
