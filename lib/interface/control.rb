require 'sinatra'
require 'yaml'

class Interface::Control < Sinatra::Base

  post "/_control/layouts" do
    begin
      tempfile = params["file"][:tempfile]
      configuration.layouts = YAML::load tempfile
    rescue Psych::SyntaxError => error
      configuration.clear_layouts!
      error 400, error.inspect
    end
  end

  get "/_control/layouts/ids" do
    respond_json configuration.layout_ids
  end

  put "/_control/layouts/:id/current" do |id|
    if configuration.layout_id?(id)
      configuration.layout_id = id
    else
      not_found
    end
  end

  get "/_control/layouts/current" do
    configuration.layout_id.to_s
  end

  get "/_control/bucket/requests" do
    respond_json bucket.requests
  end

  private

  def respond_json(object)
    content_type "application/json"
    JSON.dump object
  end

  def bucket
    Application.instance.bucket
  end

  def configuration
    Application.instance.configuration
  end

end