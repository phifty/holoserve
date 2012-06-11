require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))
require 'tempfile'

describe Holoserve::Pair::Validator do

  let(:path) do
    #file = Tempfile.new('file')
    #data = {"request" => {"method" => "GET", "path" => "/test-headers", "headers" => {"HTTP_TEST" => "value"}}, "responses" => {"default" => {"status" => 200, "body" => "test_headers"}}}
    #file.write YAML.dump(data)
    #path = file.path
    #file.close
    File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "features", "pairs", "test_headers.yaml"))
  end

  let(:path_invalid_file) do
    #file = Tempfile.new('file')
    #data = {"request" => {"methods" => "GET", "path" => "/test-headers", "headers" => {"HTTP_TEST" => "value"}}, "responses" => {"default" => {"status" => 200, "body" => "test_headers"}}}
    #file.write YAML.dump(data)
    #path = file.path
    #file.close
    File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "features", "pairs", "test_invalid_headers.yaml"))
  end

  subject { described_class.new path }

  describe "#valid?" do

    it "should return true if a valid yaml file is provided" do
      subject.valid?.should be_true
    end

    it "should return false if an invalid yaml file is provided" do
      subject.filename = path_invalid_file
      subject.valid?.should be_false
    end

  end

end