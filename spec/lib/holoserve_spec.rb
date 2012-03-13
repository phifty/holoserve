require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper"))

describe Holoserve do

  subject { described_class.new }

  describe "#start" do

    it "should not change the working directory" do
      lambda do
        subject.start
      end.should_not change(Dir, :pwd)
    end

  end

end
