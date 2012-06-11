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
      @fixtures[id] = fixture if fixture
      @logger.info "loaded fixture '#{id}'" if fixture
    end
    @fixtures.freeze
  end

  def load_pairs
    Dir[ @pair_file_pattern ].each do |filename|
      id = extract_id filename
      pair = load_file filename
      @logger.info "#{filename} has invalid format!" unless Holoserve::Pair::Validator.new(filename).valid?
      pair = nil unless Holoserve::Pair::Validator.new(filename).valid?
      @pairs[id] = pair_with_imports pair if pair
      @logger.info "loaded pair '#{id}'" if pair
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
