require 'goliath/api'

class Holoserve::Interface < Goliath::API

  autoload :Control, File.join(File.dirname(__FILE__), "interface", "control")
  autoload :Event, File.join(File.dirname(__FILE__), "interface", "event")
  autoload :Fake, File.join(File.dirname(__FILE__), "interface", "fake")

  ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..", "..")).freeze unless defined?(ROOT)

  use Goliath::Rack::Params

  def initialize
    @router = Holoserve::Request::Router.new [
      {
        :method => :get,
        :path => "/_control/bucket",
        :handler => Control::Bucket::Fetch.new
      }, {
        :method => :delete,
        :path => "/_control/bucket",
        :handler => Control::Bucket::Delete.new
      }, {
        :method => :get,
        :path => "/_control/history",
        :handler => Control::History::Fetch.new
      }, {
        :method => :delete,
        :path => "/_control/history",
        :handler => Control::History::Delete.new
      }, {
        :method => :get,
        :path => "/_control/pairs",
        :handler => Control::Pair::Index.new
      }, {
        :method => :get,
        :path => "/_control/pairs/:id",
        :handler => Control::Pair::Fetch.new
      }, {
        :method => :put,
        :path => "/_control/state",
        :handler => Control::State::Update.new
      }, {
        :method => :get,
        :path => "/_control/state",
        :handler => Control::State::Fetch.new
      }, {
        :method => :delete,
        :path => "/_control/state",
        :handler => Control::State::Delete.new
      }, {
        :path => /^\//,
        :handler => Fake.new
      }
    ]
  end

  def response(environment)
    environment["parameters"] = environment.params
    @router.dispatch environment
  end

end
