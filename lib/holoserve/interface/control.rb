require 'sinatra'
require 'yaml'
require 'json'

class Holoserve::Interface::Control < Sinatra::Base

  mime_type :yaml, "application/x-yaml"
  mime_type :json, "application/json"

  post "/_control/pairs" do
    if pair_id = load_file_into(pairs)
      logger.info "loaded pair #{pair_id}"
      acknowledgement
    else
      bad_request
    end
  end

  get "/_control/pairs.:format" do |format|
    respond_formatted params["evaluate"] ? evaluated_pairs : pairs, format
  end

  get "/_control/pairs/:id.:format" do |id, format|
    pair = (params["evaluate"] ? evaluated_pairs : pairs)[id.to_sym]
    if pair
      respond_formatted pair, format
    else
      not_found
    end
  end

  delete "/_control/pairs" do
    pairs.clear
  end

  post "/_control/fixtures" do
    if fixture_id = load_file_into(fixtures)
      logger.info "loaded fixture #{fixture_id}"
      acknowledgement
    else
      bad_request
    end
  end

  get "/_control/fixtures/:id.:format" do |id, format|
    fixture = fixtures[id.to_sym]
    if fixture
      respond_formatted fixture, format
    else
      not_found
    end
  end

  delete "/_control/fixtures" do
    fixtures.clear
  end

  put "/_control/situation" do
    configuration[:situation] = params[:name]
    logger.info "set situation to #{params[:name]}"
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

  def respond_formatted(data, format)
    if format == "yaml"
      respond_yaml data
    elsif format == "json"
      respond_json data
    else
      bad_request
    end
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

  def load_file_into(hash)
    data = load_file params["file"][:tempfile]
    return nil unless data
    id = File.basename params["file"][:filename], ".*"
    hash[id.to_sym] = Holoserve::Tool::Hash::KeySymbolizer.new(data).hash
    id.to_sym
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

  def evaluated_pairs
    result = { }
    pairs.each do |id, pair|
      result[id] = { }
      result[id][:request] = Holoserve::Fixture::Importer.new(pair[:request], fixtures).hash
      result[id][:responses] = { }
      pair[:responses].each do |situation, response|
        result[id][:responses][situation] = Holoserve::Fixture::Importer.new(response, fixtures).hash
      end
    end
    result
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

  def logger
    Holoserve.instance.logger
  end

end