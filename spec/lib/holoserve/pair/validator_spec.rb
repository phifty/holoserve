require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))

describe Holoserve::Pair::Validator do

  let(:valid_schema_path) do
    File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "schema", "schema.yaml"))
  end

  let(:invalid_schema_path) do
    File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "features", "pairs", "invalid", "test_schema.yaml"))
  end

  let(:path_valid) do
    File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "features", "pairs", "test_headers.yaml"))
  end

  let(:path_invalid_headers) do
    File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "features", "pairs", "invalid", "test_invalid_headers.yaml"))
  end

  subject { described_class.new }

  describe "#schema_valid?" do

    it "should return true if a valid schema file is provided" do
      subject.schema_path = valid_schema_path
      subject.schema_valid?.should be_true
    end

    it "should return false if an invalid schema file is provided" do
      subject.schema_path = invalid_schema_path
      subject.reload_schema
      subject.schema_valid?.should be_false
    end

  end

  describe "#valid?" do

    it "should return true if a valid pair file is provided" do
      subject.valid?(path_valid).should be_true
    end

    it "should return false if an invalid pair file is provided" do
      subject.valid?(path_invalid_headers).should be_false
    end

  end

end