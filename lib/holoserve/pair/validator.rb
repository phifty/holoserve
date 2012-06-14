require 'rubygems'
require 'kwalify'

class Holoserve::Pair::Validator

  class Error < StandardError

    def initialize(errors)
      @errors = errors
    end

    def to_s
      "<#{self.class} error count = #{@errors.size}>"
    end

    def inspect
      "#{self.class}\n  " + @errors.join("\n  ")
    end

  end

  class InvalidError < Error; end
  class InvalidSchemaError < Error; end

  attr_accessor :schema_path

  def initialize(schema_path = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "schema", "schema.yaml")))
    @schema_path = schema_path
    @meta_validator = Kwalify::MetaValidator.instance
    load_schema
    @validator = Kwalify::Validator.new(@schema)
  end

  def validate(hash)
    errors = @validator.validate(hash)
    raise InvalidError, errors if errors && !errors.empty?
  end

  private

  def load_schema
    @schema = Kwalify::Yaml::load_file(@schema_path)
    errors = @meta_validator.validate(@schema)
    raise InvalidSchemaError, errors if errors && !errors.empty?
  end

end