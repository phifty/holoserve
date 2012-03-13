require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper"))

describe Holoserve do

  subject { described_class.new }

  describe "#start" do

    after :each do
      subject.stop
    end

    it "should not change the working directory" do
      lambda do
        subject.start
      end.should_not change(Dir, :pwd)
    end

    it "should start holoserve" do
      lambda do
        subject.start
      end.should change(subject, :running?).from(false).to(true)
    end

  end

  describe "#stop" do

    before :each do
      subject.start
    end

    after :each do
      subject.stop
    end

    it "should stop holoserve" do
      lambda do
        subject.stop
      end.should change(subject, :running?).from(true).to(false)
    end

  end

end
