
When /^a (post|put|get|delete) request is performed$/ do |method|
  @expected_response = case method.to_sym
    when :post
      post "/test"
      { :status => 201, :body => "created" }
    when :put
      put "/test"
      { :status => 200, :body => "updated" }
    when :get
      get "/test"
      { :status => 200, :body => "fetched" }
    when :delete
      delete "/test"
      { :status => 200, :body => "deleted" }
  end
end

Then /^the expected response should be returned$/ do
  last_response.status.to_i.should == @expected_response[:status]
  last_response.body.should == @expected_response[:body]
end
