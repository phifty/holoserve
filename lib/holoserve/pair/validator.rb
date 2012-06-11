require 'kwalify'

class Holoserve::Pair::Validator

  attr_accessor :filename

  def initialize(filename)
    @filename = filename
  end

  def valid?
    return false if @filename.nil?
    return false unless load_schema
    return false unless load_file
    errors = @validator.validate(@document)
    return false if errors && !errors.empty?
    true
  end

  private

  def load_schema
    begin
      schema = Kwalify::Yaml::load_file(File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "schema", "schema.yaml")))
    rescue Psych::SyntaxError
      return false
      end
    @validator = Kwalify::Validator.new(schema)
    true
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