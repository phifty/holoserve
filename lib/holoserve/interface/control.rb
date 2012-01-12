require 'sinatra'
require 'yaml'
require 'json'

class Holoserve::Interface::Control < Sinatra::Base

  post "/_control/layout" do
    begin
      configuration.load_layout_from_yml_file params["file"][:tempfile]
      respond_json_acknowledgement
    rescue Psych::SyntaxError => error
      error 400, error.inspect
    end
  end

  get "/_control/layout.:format" do |format|
    if format == "yaml"
      respond_yaml configuration.layout
    elsif format == "json"
      respond_json configuration.layout
    else
      not_acceptable
    end
  end

  delete "/_control/layout" do
    configuration.clear_layout!
    respond_json_acknowledgement
  end

  put "/_control/situation/:name" do |situation|
    configuration.situation = situation
    respond_json_acknowledgement
  end

  get "/_control/situation" do
    configuration.situation.to_s
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

  def respond_yaml(object)
    content_type "application/x-yaml"
    object.to_yaml
  end

  def not_acceptable
    [ 406, { }, [ "format not acceptable" ] ]
  end

  def bucket
    Holoserve.instance.bucket
  end

  def history
    Holoserve.instance.history
  end

  def configuration
    Holoserve.instance.configuration
  end

end