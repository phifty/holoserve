require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))

describe Holoserve::Tool::DataPath do

  subject { described_class.new nil, nil }

  describe "fetch" do

    it "should return the given data if no path is specified" do
      subject.path = nil
      subject.data = { :test => "value" }.freeze
      subject.fetch.should == { :test => "value" }
    end

    it "should return the value specified by the given path" do
      subject.path = "test"
      subject.data = { :test => "value" }.freeze
      subject.fetch.should == "value"
    end

    it "should return the value even if string keys are used" do
      subject.path = "test"
      subject.data = { "test" => "value" }.freeze
      subject.fetch.should == "value"
    end

    it "should return the nested value specified by the given path" do
      subject.path = "test.nested"
      subject.data = { :test => { :nested => "value" }.freeze }.freeze
      subject.fetch.should == "value"
    end

    it "should return nil if the path points to nowhere" do
      subject.path = "test.nested"
      subject.data = { :test => true }.freeze
      subject.fetch.should be_nil
    end

    it "should return nil if the last path element doesn't exists'" do
      subject.path = "test.nested"
      subject.data = { :test => { :another => "value" }.freeze }.freeze
      subject.fetch.should be_nil
    end

    it "should return in an array nested value specified by the given path" do
      subject.path = "test.1.nested"
      subject.data = { :test => [ { }.freeze, { :nested => "value" }.freeze ].freeze }.freeze
      subject.fetch.should == "value"
    end

  end

  describe "store" do

    it "should merge the given value with the root element if no path is given" do
      subject.path = nil
      subject.data = { :test => "value" }.freeze
      subject.store(:another => "value").should == { :test => "value", :another => "value" }
    end

    it "should return the value if no path is given and value is not mergeable" do
      subject.path = nil
      subject.data = { :test => "value" }.freeze
      subject.store("value").should == "value"
    end

    it "should store the given value at the specified path" do
      subject.path = "another"
      subject.data = { :test => "value" }.freeze
      subject.store("value").should == { :test => "value", :another => "value" }
    end

    it "should store the given value in a nested hash" do
      subject.path = "test.another"
      subject.data = { :test => { :nested => "value" }.freeze }.freeze
      subject.store("value").should == { :test => { :nested => "value", :another => "value" } }
    end

    it "should store the given value at the specified path and create it if missing" do
      subject.path = "another.test"
      subject.data = { :test => "value" }.freeze
      subject.store("value").should == { :test => "value", :another => { :test => "value" } }
    end

  end

end
