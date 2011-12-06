require 'sinatra'

class Application::Interface::Control < Sinatra::Base

  post "/_control/layouts" do

  end

  get "/_control/layouts/ids" do
    JSON.dump [ "one", "two" ]
  end

  put "/_control/layouts/:id" do |id|
    configuration.layout = id
  end

  get "/_control/layouts/current" do
    configuration.layout
  end

  private

  def configuration
    Application.instance.configuration
  end

end