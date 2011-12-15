
When /^the regular (.+) is performed$/ do |request|
  perform request
end

When /^the regular (.+) is performed with (.+)$/ do |request, extra|
  perform request.merge(extra)
end

Then /^the (.+) should be returned$/ do |response|
  last_response_status.to_i.should == response[:status]
  last_response_body.should == response[:body]
end
