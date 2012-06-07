require File.expand_path("../../../../helper", File.dirname(__FILE__))

describe Holoserve::Tool::Hash::Matcher do

  let(:hash) do
    {
      :test => "value",
      :nested => {
        :unspecified => "value",
        :another => "test value"
      },
      :unspecified => "value",
      :nested_array => [{:hash => "value", :unspecified => "value", :morehash => {:test => "value", :unspecified => "value", :array => [{:test => "value"}]}}]
    }
  end

  let(:matching_subset) do
    {
      :test => "value"
    }
  end

  let(:matching_subset_with_nested_hash) do
    {
      :nested => {
        :another => "test value"
      }
    }
  end

  let(:matching_subset_with_nested_array) do
    {
      :nested_array => [{:hash => "value"}]
    }
  end

  let(:matching_subset_with_nested_array_and_nested_hash) do
    {
      :nested_array => [{:hash => "value", :morehash => {:test => "value"}}]
    }
  end

  let(:matching_subset_with_nested_array_and_nested_hash_and_nested_array) do
    {
      :nested_array => [{:hash => "value", :morehash => {:test => "value", :array => [{:test => "value"}]}}]
    }
  end

  let(:mismatching_subset) do
    {
      :test => "another value"
    }
  end

  let(:mismatching_subset_with_nested_hash) do
    {
      :nested => {
        :another => "another value"
      }
    }
  end

  let(:mismatching_subset_with_nested_array) do
    {
      :nested_array => [{:hash => "other value"}]
    }
  end

  let(:mismatching_subset_with_nested_array_and_nested_hash) do
    {
      :nested_array => [{:hash => "value", :morehash => {:test => "other value"}}]
    }
  end

  let(:mismatching_subset_with_nested_array_and_nested_hash_and_nested_array) do
    {
      :nested_array => [{:hash => "value", :morehash => {:test => "value", :array => [{:test => "other value"}]}}]
    }
  end

  subject { described_class.new hash, matching_subset }

  describe "#match?" do

    it "should return true if a matching subset is provided" do
      subject.match?.should be_true
    end

    it "should return false if a mismatching subset is provided" do
      subject.subset = mismatching_subset
      subject.match?.should be_false
    end

    it "should return true if a matching subset with nested hash is provided" do
      subject.subset = matching_subset_with_nested_hash
      subject.match?.should be_true
    end

    it "should return false if a mismatching subset with nested hash is provided" do
      subject.subset = mismatching_subset_with_nested_hash
      subject.match?.should be_false
    end

    it "should return true if a matching subset with nested array is provided" do
      subject.subset = matching_subset_with_nested_array
      subject.match?.should be_true
    end

    it "should return false if a mismatching subset with nested array is provided" do
      subject.subset = mismatching_subset_with_nested_array
      subject.match?.should be_false
    end

    it "should return true if a matching subset with nested array and nested hash is provided" do
      subject.subset = matching_subset_with_nested_array_and_nested_hash
      subject.match?.should be_true
    end

    it "should return false if a mismatching subset with nested array and nested hash is provided" do
      subject.subset = mismatching_subset_with_nested_array_and_nested_hash
      subject.match?.should be_false
    end

    it "should return true if a matching subset with nested array and nested hash and nested array is provided" do
      subject.subset = matching_subset_with_nested_array_and_nested_hash_and_nested_array
      subject.match?.should be_true
    end

    it "should return false if a mismatching subset with nested array and nested hash and nested array is provided" do
      subject.subset = mismatching_subset_with_nested_array_and_nested_hash_and_nested_array
      subject.match?.should be_false
    end

  end

end
