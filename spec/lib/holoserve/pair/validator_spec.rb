require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))
require 'yaml'

describe Holoserve::Pair::Validator do

  let(:valid_schema_path) do
    File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "schema", "schema.yaml"))
  end

  let(:invalid_schema_path) do
    File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "features", "pairs", "invalid", "test_invalid_schema.yaml"))
  end

  let(:valid_hash) do
    file = YAML::load_file(File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "features", "pairs", "test_headers.yaml")))
    Holoserve::Tool::Hash::KeySymbolizer.new(file).hash
  end

  let(:invalid_hash) do
    file = YAML::load_file(File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "features", "pairs", "invalid", "test_invalid_headers.yaml")))
    Holoserve::Tool::Hash::KeySymbolizer.new(file).hash
  end

  subject { described_class.new valid_schema_path }

  describe "#initialize" do

    it "should raise an InvalidSchemaError if the schema file is invalid" do
      lambda do
        described_class.new invalid_schema_path
      end.should raise_error(described_class::InvalidSchemaError)
    end

  end

  describe "#validate" do

    it "should return true if a valid pair file is provided" do
      lambda do
        subject.validate(valid_hash)
      end.should_not raise_error
    end

    it "should return false if an invalid pair file is provided" do
      lambda do
        subject.validate(invalid_hash)
      end.should raise_error(described_class::InvalidError)
    end

  end

end