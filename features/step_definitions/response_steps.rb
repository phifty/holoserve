
Then /^the responded status code should be (\d+)$/ do |status_code|
  last_response.status.to_i.should == status_code.to_i
end
