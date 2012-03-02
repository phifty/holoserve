require 'goliath/api'

class Holoserve::Interface < Goliath::API

  autoload :Control, File.join(File.dirname(__FILE__), "interface", "control")
  autoload :Fake, File.join(File.dirname(__FILE__), "interface", "fake")

  get "/_control/bucket", Control::Bucket::Fetch
  delete "/_control/bucket", Control::Bucket::Delete

  get "/_control/history", Control::History::Fetch
  delete "/_control/history", Control::History::Delete

  get "/_control/pairs", Control::Pair::Index
  get "/_control/pairs/:id", Control::Pair::Fetch

  put "/_control/state", Control::State::Update
  get "/_control/state", Control::State::Fetch
  delete "/_control/state", Control::State::Delete

  map "/*", Fake

end
