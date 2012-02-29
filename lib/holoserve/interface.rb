require 'goliath/api'

class Holoserve::Interface < Goliath::API

  autoload :Control, File.join(File.dirname(__FILE__), "interface", "control")
  autoload :Fake, File.join(File.dirname(__FILE__), "interface", "fake")

  put "/_control/situation", Control::UpdateSituation
  get "/_control/situation", Control::FetchSituation
  get "/_control/bucket", Control::FetchBucket
  delete "/_control/bucket", Control::DestroyBucket
  get "/_control/history", Control::FetchHistory
  delete "/_control/history", Control::DestroyHistory

  map "/*", Fake

end
