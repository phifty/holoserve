require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))

describe Holoserve::Data::Builder do

  let(:fixtures) { { :test => { :nested => "value" }, :another => "value" } }

  subject { described_class.new nil, fixtures }

  describe "data" do

    it "should return a hash with imported fixtures" do
      subject.outline = {
        :imports => [
          { :path => "test.nested" }
        ]
      }
      subject.data.should == "value"
    end

    it "should return a hash with imported fixtures that has a target path" do
      subject.outline = {
        :imports => [
          { :path => "test.nested", :as => "test" }
        ]
      }
      subject.data.should == { :test => "value" }
    end

    it "should return a hash where all the imports are imported" do
      subject.outline = {
        :imports => [
          { :path => "test.nested", :as => "test" },
          { :path => "another", :as => "another.test" }
        ]
      }
      subject.data.should == { :test => "value", :another => { :test => "value" } }
    end

    it "should return a hash where the data is merged with the imports" do
      subject.outline = {
        :imports => [
          { :path => "test.nested", :as => "test" }
        ],
        :data => {
          :another => "value"
        }
      }
      subject.data.should == { :test => "value", :another => "value" }
    end

    it "should return a hash where the data is deep merged with the imports" do
      subject.outline = {
        :imports => [
          { :path => "test.nested", :as => "test.nested" }
        ],
        :data => {
          :test => {
            :another => "value"
          }
        }
      }
      subject.data.should == { :test => { :nested => "value", :another => "value" } }
    end

  end

end
