
Then /^the history should contain the ((test|unhandled) (post|put|get|delete) pair name)$/ do |pair_name, type, method|
  get "/_control/history"
  last_json_response_body.should include(pair_name)
end
