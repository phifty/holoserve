
Transform /^response for test (post|put|get|delete) request$/ do |method|
  case method.to_sym
    when :post
      { :status => 201, :body => "created" }
    when :put
      { :status => 200, :body => "updated" }
    when :get
      { :status => 200, :body => "fetched" }
    when :delete
      { :status => 200, :body => "deleted" }
  end
end

Transform /^response for unhandled (post|put|get|delete) request$/ do |method|
  { :status => 404, :body => "no response found for this request" }
end

Then /^the responded status code should be (\d+)$/ do |status_code|
  last_response.status.to_i.should == status_code.to_i
end

Then /^the responded body should include an acknowledgement$/ do
  last_json_response_body.should == { "ok" => true }
end

Then /^the responded body should not include an acknowledgement$/ do
  begin
    last_json_response_body.should_not == { "ok" => true }
  rescue JSON::ParserError

  end
end
