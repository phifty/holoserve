
Then /^the bucket should contain the unhandled (post|put|get|delete) request$/ do |method|
  get "/_control/bucket/requests"
  request = case method.to_sym
    when :post
      { "method" => "POST", "path" => "/unhandled" }
    when :put
      { "method" => "PUT", "path" => "/unhandled" }
    when :get
      { "method" => "GET", "path" => "/unhandled" }
    when :delete
      { "method" => "DELETE", "path" => "/unhandled" }
  end
  last_json_response_body.should include(request)
end
