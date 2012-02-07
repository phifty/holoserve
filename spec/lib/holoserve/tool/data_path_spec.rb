require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))

describe Holoserve::Tool::DataPath do

  subject { described_class.new nil, nil }

  describe "fetch" do

    it "should return the value specified by the given path" do
      subject.path = "test"
      subject.data = { :test => "value" }
      subject.fetch.should == "value"
    end

    it "should return the nested value specified by the given path" do
      subject.path = "test.nested"
      subject.data = { :test => { :nested => "value" } }
      subject.fetch.should == "value"
    end

    it "should return nil if the path points to nowhere" do
      subject.path = "test.nested"
      subject.data = { :test => true }
      subject.fetch.should be_nil
    end

    it "should return nil if the last path element doesn't exists'" do
      subject.path = "test.nested"
      subject.data = { :test => { :another => "value" } }
      subject.fetch.should be_nil
    end

    it "should return in an array nested value specified by the given path" do
      subject.path = "test.1.nested"
      subject.data = { :test => [ { }, { :nested => "value" } ] }
      subject.fetch.should == "value"
    end

  end

end
