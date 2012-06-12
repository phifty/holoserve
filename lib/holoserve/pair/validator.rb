require 'kwalify'

class Holoserve::Pair::Validator

  class InvalidSchemaError < StandardError
  end

  attr_accessor :filename
  attr_accessor :schema_path

  def initialize
    @schema_path = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "schema", "schema.yaml"))
    load_schema
    raise InvalidSchemaError unless schema_valid?
    @validator = Kwalify::Validator.new(@schema) if schema_valid?
  end

  def valid?(filename)
    @filename = filename
    return false if @filename.nil?
    return false unless load_file
    @errors = @validator.validate(@document)
    return false if @errors && !@errors.empty?
    true
  end

  def get_meta_validation_errors
    log = ""
    meta_validator = Kwalify::MetaValidator.instance
    meta_errors = meta_validator.validate(@schema)
    if meta_errors && !meta_errors.empty?
      meta_errors.each do |error|
        log << "[#{error.path}] #{error.message}"
      end
    end
    log
  end

  def get_validation_errors
    log = ""
    if @errors && !@errors.empty?
      @errors.each do |error|
        log << "[#{error.path}] #{error.message}"
      end
    end
    log
  end

  def schema_valid?
    return true if get_meta_validation_errors.empty?
    false
  end

  def reload_schema
    @schema = Kwalify::Yaml::load_file(@schema_path)
    rescue Psych::SyntaxError
  end

  private

  def load_schema
    @schema = Kwalify::Yaml::load_file(@schema_path)
    rescue Psych::SyntaxError
  end

  def load_file
    begin
      @document = Kwalify::Yaml::load_file(@filename)
    rescue Psych::SyntaxError
      return false
    end
    true
  end

end