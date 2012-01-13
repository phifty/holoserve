require 'yaml'

class Holoserve::Configuration

  class InvalidFormatError < StandardError; end

  attr_reader :logger

  attr_reader :layout
  attr_reader :situation

  def initialize(logger)
    @logger = logger
  end

  def layout=(hash_or_array)
    @layout = Holoserve::Tool::Hash::KeySymbolizer.new(hash_or_array).hash
  end

  def situation=(value)
    @situation = value.to_sym
    logger.info "made '#{value}' the current situation"
  end

  def clear_layout!
    self.layout = nil
  end

  def load_layout_from_yaml_file(file)
    self.layout = YAML::load_file file
    logger.info "loaded layouts from yaml file #{file.path}"
  rescue Psych::SyntaxError => error
    self.clear_layout!
    raise InvalidFormatError, error.to_s
  end

  def load_layout_from_json_file(file)
    self.layout = JSON.parse File.read(file)
    logger.info "loaded layouts from json file #{file.path}"
  rescue JSON::ParserError => error
    self.clear_layout!
    raise InvalidFormatError, error.to_s
  end

end
