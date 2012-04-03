require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))

describe Holoserve::Tool::Merger do

  subject { described_class.new argument_one, argument_two }

  describe "result" do

    context "of two hashes" do

      let(:argument_one) { { :test => "value" } }
      let(:argument_two) { { :test => "another value" } }

      it "should merge nested values" do
        subject.result.should == { :test => "another value" }
      end

    end

    context "of two hashes with boolean values" do

      let(:argument_one) { { :one => false, :two => true } }
      let(:argument_two) { { :one => true, :two => false } }

      it "should merge hashes with boolean values" do
        subject.result.should == { :one => true, :two => false }
      end

    end

    context "of two nested hashes" do

      let(:argument_one) { { :test => { :regular =>"value", :nested => "value" } } }
      let(:argument_two) { { :test => { :nested => "another value" } } }

      it "should merge nested values" do
        subject.result.should == { :test => { :regular => "value", :nested => "another value" } }
      end

    end

    context "of two arrays" do

      let(:argument_one) { [ { :test => "value" }, { :regular => "value", :another_test => "value" } ] }
      let(:argument_two) { [ { :test => "another value" }, { :another_test => "another value" } ] }

      it "should merge all nested hashes" do
        subject.result.should == [
          { :test => "another value" },
          { :regular => "value", :another_test => "another value" }
        ]
      end

    end

    context "of two arrays with different lengths" do

      let(:argument_one) { [ { :test => "value" } ] }
      let(:argument_two) { [ { :test => "another value" }, { :another_test => "another value" } ] }

      it "should merge all nested hashes" do
        subject.result.should == [
          { :test => "another value" },
          { :another_test => "another value" }
        ]
      end

    end

    context "of two arrays in fusion mode" do

      before :each do
        subject.mode = :fusion
      end

      let(:argument_one) { [ 1 ] }
      let(:argument_two) { [ 2, 3 ] }

      it "should combine all arrays" do
        subject.result.should == [ 1, 2, 3 ]
      end

    end

  end

end
