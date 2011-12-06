require 'sinatra'

class Application::Interface::Control < Sinatra::Base

  put "/_control/layouts/:id" do |id|
    configuration.layout = id
  end

  get "/_control/layouts" do
    configuration.layout
  end

  private

  def configuration
    Application.instance.configuration
  end

end