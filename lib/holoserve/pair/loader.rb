require 'yaml'
require 'json'

class Holoserve::Pair::Loader

  def initialize(fixture_file_pattern, pair_file_pattern, logger)
    @fixtures, @pairs = { }, { }
    @fixture_file_pattern, @pair_file_pattern = fixture_file_pattern, pair_file_pattern
    @logger = logger
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
    validator = Holoserve::Pair::Validator.new
    unless validator.schema_valid?
      @logger.info "schema file is invalid: " + validator.get_meta_validation_errors
      return
    end
    Dir[ @pair_file_pattern ].each do |filename|
      id = extract_id filename
      pair = load_file filename
      unless validator.valid? filename
        @logger.info "#{filename} is invalid: " + validator.get_validation_errors
        pair = nil
      end
      if pair
        @pairs[id] = pair_with_imports pair
        @logger.info "loaded pair '#{id}'"
      end
    end
    @pairs.freeze
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
    result = {
      :request => Holoserve::Fixture::Importer.new(pair[:request], @fixtures).result,
      :responses => { }
    }
    (pair[:responses] || { }).each do |id, response|
      result[:responses][id] = Holoserve::Fixture::Importer.new(response, @fixtures).result
    end
    result
  end

end
