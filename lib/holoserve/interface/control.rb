require 'sinatra'
require 'yaml'
require 'json'

class Holoserve::Interface::Control < Sinatra::Base

  mime_type :yaml, "application/x-yaml"
  mime_type :json, "application/json"

  post "/_control/pairs" do
    pair = load_file params["file"][:tempfile]
    if pair
      id = File.basename params["file"][:filename], ".*"
      pairs[id] = Holoserve::Tool::Hash::KeySymbolizer.new(pair).hash
      acknowledgement
    else
      bad_request
    end
  end

  get "/_control/pairs/:id.:format" do |id, format|
    pair = pairs[id]
    if pair
      if format == "yaml"
        respond_yaml pair
      elsif format == "json"
        respond_json pair
      else
        bad_request
      end
    else
      not_found
    end
  end

  delete "/_control/pairs" do
    pairs.clear
  end

  post "/_control/fixtures" do
    fixture = load_file params["file"][:tempfile]
    if fixture
      id = File.basename params["file"][:filename], ".*"
      fixtures[id] = Holoserve::Tool::Hash::KeySymbolizer.new(fixture).hash
      acknowledgement
    else
      bad_request
    end
  end

  get "/_control/fixtures/:id.:format" do |id, format|
    fixture = fixtures[id]
    if fixture
      if format == "yaml"
        respond_yaml fixture
      elsif format == "json"
        respond_json fixture
      else
        bad_request
      end
    else
      not_found
    end
  end

  delete "/_control/fixtures" do
    fixtures.clear
  end

  put "/_control/situation" do
    configuration[:situation] = params[:name]
    respond_json_acknowledgement
  end

  get "/_control/situation" do
    respond_json :name => configuration[:situation]
  end

  get "/_control/bucket" do
    respond_json bucket
  end

  delete "/_control/bucket" do
    bucket.clear
  end

  get "/_control/history" do
    respond_json history
  end

  delete "/_control/history" do
    history.clear
    respond_json_acknowledgement
  end

  private

  def respond_json_acknowledgement
    respond_json :ok => true
  end

  def respond_json(object)
    content_type :json
    JSON.dump object
  end

  def respond_yaml(object)
    content_type :yaml
    object.to_yaml
  end

  def acknowledgement
    [ 200, { }, [ "" ] ]
  end

  def bad_request
    [ 400, { }, [ "bad request" ] ]
  end

  def not_acceptable
    [ 406, { }, [ "format not acceptable" ] ]
  end

  def load_file(filename)
    YAML::load_file filename
  rescue Psych::SyntaxError
    begin
      JSON.parse File.read(filename)
    rescue JSON::ParserError
      nil
    end
  end

  def pairs
    configuration[:pairs]
  end

  def fixtures
    configuration[:fixtures]
  end

  def bucket
    configuration[:bucket]
  end

  def history
    configuration[:history]
  end

  def configuration
    Holoserve.instance.configuration
  end

end