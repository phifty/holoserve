require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))

describe Holoserve::Fixture::Importer do

  let(:fixtures) { { :test => { :nested => "value", :second => "value" }, :another => "value" } }

  subject { described_class.new nil, fixtures }

  describe "hash" do

    it "should return the original hash if there is no imports section" do
      subject.hash = {
        :test => "value"
      }
      subject.hash.should == { :test => "value" }
    end

    it "should return a hash with imported fixtures" do
      subject.hash = {
        :imports => [
          { :path => "test.nested" }
        ]
      }
      subject.hash.should == { :test => { :nested => "value" } }
    end

    it "should return a hash with imported fixtures at a target path" do
      subject.hash = {
        :imports => [
          { :path => "test.nested", :as => "test" }
        ]
      }
      subject.hash.should == { :test => "value" }
    end

    it "should return a hash with imported and filtered fixtures" do
      subject.hash = {
        :imports => [
          { :path => "test", :as => "test", :only => [ "second" ] }
        ]
      }
      subject.hash.should == { :test => { :second => "value" } }
    end

    it "should return a hash where all the imports are imported" do
      subject.hash = {
        :imports => [
          { :path => "test.nested", :as => "test" },
          { :path => "another", :as => "another.test" }
        ]
      }
      subject.hash.should == { :test => "value", :another => { :test => "value" } }
    end

    it "should return a hash where the data is merged with the imports" do
      subject.hash = {
        :imports => [
          { :path => "test.nested", :as => "test" }
        ],
        :another => "value"
      }
      subject.hash.should == { :test => "value", :another => "value" }
    end

    it "should return a hash where the data is deep merged with the imports" do
      subject.hash = {
        :imports => [
          { :path => "test.nested", :as => "test.nested" }
        ],
        :test => {
          :another => "value"
        }
      }
      subject.hash.should == { :test => { :nested => "value", :another => "value" } }
    end

  end

end
