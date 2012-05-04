require 'goliath/api'

class Holoserve::Interface < Goliath::API

  autoload :Control, File.join(File.dirname(__FILE__), "interface", "control")
  autoload :Event, File.join(File.dirname(__FILE__), "interface", "event")
  autoload :Fake, File.join(File.dirname(__FILE__), "interface", "fake")

  ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..", "..")).freeze unless defined?(ROOT)

  use Rack::Static,
      :root => File.join(ROOT, "public"),
      :urls => {
        "/_control/favicon.ico" => "favicon.ico",
        "/_control/javascripts/vendor/jquery-1.7.2.min.js" => "javascripts/vendor/jquery-1.7.2.min.js",
        "/_control/javascripts/vendor/jquery.color.js" => "javascripts/vendor/jquery.color.js",
        "/_control/javascripts/vendor/bootstrap-transition.js" => "javascripts/vendor/bootstrap-transition.js"
      }

  map "/_control/event", Event

  get "/_control/bucket", Control::Bucket::Fetch
  delete "/_control/bucket", Control::Bucket::Delete

  get "/_control/history", Control::History::Fetch
  delete "/_control/history", Control::History::Delete

  get "/_control/pairs", Control::Pair::Index
  get "/_control/pairs/:id", Control::Pair::Fetch

  put "/_control/state", Control::State::Update
  get "/_control/state", Control::State::Fetch
  delete "/_control/state", Control::State::Delete

  get "/_control*", Control::Index::Fetch

  map "/*", Fake

end
