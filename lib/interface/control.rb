require 'sinatra'
require 'yaml'

class Interface::Control < Sinatra::Base

  post "/_control/layouts" do
    begin
      tempfile = params["file"][:tempfile]
      configuration.layouts = YAML::load tempfile
      respond_json_acknowledgement
    rescue Psych::SyntaxError => error
      configuration.clear_layouts!
      error 400, error.inspect
    end
  end

  delete "/_control/layouts" do
    configuration.clear_layouts!
    respond_json_acknowledgement
  end

  get "/_control/layouts/ids" do
    respond_json configuration.layout_ids
  end

  put "/_control/layouts/:id/current" do |id|
    if configuration.layout_id?(id)
      configuration.layout_id = id
      respond_json_acknowledgement
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

  get "/_control/history" do
    respond_json history.pair_names
  end

  delete "/_control/history" do
    history.clear!
    respond_json_acknowledgement
  end

  private

  def respond_json_acknowledgement
    respond_json :ok => true
  end

  def respond_json(object)
    content_type "application/json"
    JSON.dump object
  end

  def bucket
    Holoserve::Server.instance.bucket
  end

  def history
    Holoserve::Server.instance.history
  end

  def configuration
    Holoserve::Server.instance.configuration
  end

end