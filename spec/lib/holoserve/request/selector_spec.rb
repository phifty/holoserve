require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))

describe Holoserve::Request::Selector do

  let(:subsets) do
    {
      :default => {
        :method => "GET",
        :path => "/test"
      },
      :test => {
        :headers => {
          :HTTP_TEST => "value"
        }
      }
    }
  end

  let(:variant_matching_request) do
    {
      :method => "GET",
      :path => "/test",
      :headers => {
        :HTTP_TEST => "value",
        :HTTP_HOST => "localhost"
      }
    }
  end

  let(:invalid_request) do
    {
      :method => "POST",
      :other_test => {
        :key => "value"
      }
    }
  end

  let(:default_matching_request) do
    {
      :method => "GET",
      :path => "/test",
      :parameters => {
        :test => "value"
      }
    }
  end

  subject { described_class.new invalid_request, subsets }

  describe "#selection" do

    it "should return nil if request is not matching default nor any other subset" do
      subject.selection.should be_nil
    end

    it "should return :default if the default subset is matched" do
      subject.request = default_matching_request
      subject.selection.should == :default
    end

    it "should return :test if the corresponding subset is matched" do
      subject.request = variant_matching_request
      subject.selection.should == :test
    end

  end

end