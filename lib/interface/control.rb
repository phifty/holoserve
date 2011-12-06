require 'sinatra'
require 'yaml'

class Application::Interface::Control < Sinatra::Base

  post "/_control/layouts" do
    tempfile = params["file"][:tempfile]
    configuration.layouts = YAML::load tempfile
  end

  get "/_control/layouts/ids" do
    respond_json configuration.layouts.keys
  end

  put "/_control/layouts/:id/current" do |id|
    configuration.layout = id
  end

  get "/_control/layouts/current" do
    configuration.layout
  end

  private

  def respond_json(object)
    content_type "application/json"
    JSON.dump object
  end

  def configuration
    Application.instance.configuration
  end

end