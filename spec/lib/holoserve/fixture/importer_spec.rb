require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))

describe Holoserve::Fixture::Importer do

  let(:fixtures) do
    {
      :one => { :first => 1, :second => 2 }.freeze,
      :two => 3,
      :three => { :third => 4 }.freeze
    }.freeze
  end

  subject { described_class.new nil, fixtures }

  describe "hash" do

    it "should return the original hash if there is no imports section" do
      subject.hash = {
        :test => "value"
      }
      subject.result.should == { :test => "value" }
    end

    it "should return a hash with imported fixtures" do
      subject.hash = {
        :imports => [
          { :path => "one" }
        ]
      }
      subject.result.should == { :first => 1, :second => 2 }
    end

    it "should return a hash with imported fixtures at a target path" do
      subject.hash = {
        :imports => [
          { :path => "one.first", :as => "test" }
        ]
      }
      subject.result.should == { :test => 1 }
    end

    it "should return a hash with imported and white-list filtered fixtures" do
      subject.hash = {
        :imports => [
          { :path => "one", :as => "test", :only => "second" }
        ]
      }
      subject.result.should == { :test => { :second => 2 } }
    end

    it "should return a hash with imported and black-list filtered fixtures" do
      subject.hash = {
        :imports => [
          { :path => "one", :as => "test", :except => [ "second" ] }
        ]
      }
      subject.result.should == { :test => { :first => 1 } }
    end

    it "should return a hash where all the imports are imported" do
      subject.hash = {
        :imports => [
          { :path => "one.first", :as => "test" },
          { :path => "two", :as => "another.test" }
        ]
      }
      subject.result.should == { :test => 1, :another => { :test => 3 } }
    end

    it "should return a hash where all the imports are merged together" do
      subject.hash = {
        :imports => [
          { :path => "one" },
          { :path => "three" }
        ]
      }
      subject.result.should == { :first => 1, :second => 2, :third => 4 }
    end

    it "should return a hash where all the imports (with and without an :as statement) are properly merged together" do
      subject.hash = {
        :imports => [
          { :path => "one" },
          { :path => "two", :as => "test" },
          { :path => "three", :as => "another" }
        ]
      }
      subject.result.should == { :first => 1, :second => 2, :test => 3, :another => { :third => 4 } }
    end

    it "should return a hash where the data is merged with the imports" do
      subject.hash = {
        :imports => [
          { :path => "one.first", :as => "test" }
        ],
        :another => "value"
      }
      subject.result.should == { :test => 1, :another => "value" }
    end

    it "should return a hash where the data is deep merged with the imports" do
      subject.hash = {
        :imports => [
          { :path => "one.first", :as => "test.nested" }
        ],
        :test => {
          :another => "value"
        }
      }
      subject.result.should == { :test => { :nested => 1, :another => "value" } }
    end

    it "should not destroy the original hash and stay repeatable" do
      hash = {
        :imports => [
          { :path => "three" },
          { :path => "one.first", :as => "test.nested" }
        ],
        :test => {
          :another => "value"
        }
      }
      subject.hash = hash
      subject.result.should == { :third => 4, :test => { :nested => 1, :another => "value" } }

      importer = described_class.new hash, fixtures
      importer.result.should == { :third => 4, :test => { :nested => 1, :another => "value" } }
    end

  end

end
