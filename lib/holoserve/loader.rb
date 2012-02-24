require 'yaml'
require 'json'

class Holoserve::Loader

  def initialize(fixture_file_pattern, pair_file_pattern)
    @configuration = { }
    @fixture_file_pattern, @pair_file_pattern = fixture_file_pattern, pair_file_pattern
  end

  def configuration
    load_fixtures if @fixture_file_pattern
    load_pairs if @pair_file_pattern
    @configuration
  end

  private

  def load_fixtures
    Dir[ @fixture_file_pattern ].each do |filename|
      load_file :fixtures, filename
    end
    @configuration[:fixtures].freeze
  end

  def load_pairs
    Dir[ @pair_file_pattern ].each do |filename|
      load_file :pairs, filename
    end
    @configuration[:pairs].freeze
  end

  def load_file(key, filename)
    format = File.extname(filename).sub(/^\./, "")
    raise ArgumentError, "file extension indicates wrong format '#{format}' (choose yaml or json)" unless [ "yaml", "json" ].include?(format)
    id = File.basename filename, ".*"
    data = begin
        YAML::load_file filename
      rescue Psych::SyntaxError
        begin
          JSON.parse File.read(filename)
        rescue JSON::ParserError
          nil
        end
      end
    if data
      @configuration[key] ||= { }
      @configuration[key][id] = data
    end
  end

end
