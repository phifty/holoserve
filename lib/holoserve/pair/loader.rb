require 'yaml'
require 'json'

class Holoserve::Pair::Loader

  def initialize(fixture_file_pattern, pair_file_pattern, logger)
    @fixtures, @pairs = { }, { }
    @fixture_file_pattern, @pair_file_pattern = fixture_file_pattern, pair_file_pattern
    @logger = logger
    @validator = Holoserve::Pair::Validator.new
  rescue Holoserve::Pair::Validator::InvalidSchemaError => error
    @logger.error error.inspect
  end

  def pairs
    load_fixtures if @fixture_file_pattern
    load_pairs if @pair_file_pattern
    @pairs
  end

  private

  def load_fixtures
    Dir[ @fixture_file_pattern ].each do |filename|
      id = extract_id filename
      fixture = load_file filename
      if fixture
        @fixtures[id] = fixture
        @logger.info "loaded fixture '#{id}'"
      end
    end
    @fixtures.freeze
  end

  def load_pairs
    Dir[ @pair_file_pattern ].each do |filename|
      load_pair filename
    end
    @pairs.freeze
  end

  def load_pair(filename)
    id = extract_id filename
    pair = load_file filename
    if pair
      @validator.validate(pair)
      @pairs[id] = pair_with_imports pair
      @logger.info "loaded pair '#{id}'"
    end
  rescue Holoserve::Pair::Validator::InvalidError => error
    @logger.error error.inspect
  end

  def extract_id(filename)
    File.basename filename, ".*"
  end

  def load_file(filename)
    format = File.extname(filename).sub(/^\./, "")
    raise ArgumentError, "file extension indicates wrong format '#{format}' (choose yaml or json)" unless [ "yaml", "json" ].include?(format)
    data = begin
        YAML::load_file filename
      rescue Psych::SyntaxError
        begin
          JSON.parse File.read(filename)
        rescue JSON::ParserError
          nil
        end
    end
    Holoserve::Tool::Hash::KeySymbolizer.new(data).hash
  end

  def pair_with_imports(pair)
    result = { :requests => { }, :responses => { } }

    pair[:requests].each do |variant, request|
      result[:requests][variant] = Holoserve::Fixture::Importer.new(request, @fixtures).result
    end

    pair[:responses].each do |variant, response|
      result[:responses][variant] = Holoserve::Fixture::Importer.new(response, @fixtures).result
    end

    result
  end

end
