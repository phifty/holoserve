require 'goliath/api'

class Holoserve::Interface < Goliath::API

  autoload :Control, File.join(File.dirname(__FILE__), "interface", "control")
  autoload :Fake, File.join(File.dirname(__FILE__), "interface", "fake")

  put "/_control/situation", Control::Situation::Update
  get "/_control/situation", Control::Situation::Fetch

  get "/_control/bucket", Control::Bucket::Fetch
  delete "/_control/bucket", Control::Bucket::Delete

  get "/_control/history", Control::History::Fetch
  delete "/_control/history", Control::History::Delete

  map "/*", Fake

end
