require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "helper"))

describe Holoserve::Request::Router do

  let(:test_handler_one) { Object.new }
  let(:test_handler_two) { Object.new }
  let(:test_handler_three) { Object.new }

  let(:routes) do
    [
      {
        :method => :get,
        :path => "/test",
        :handler => test_handler_one
      }, {
        :method => :get,
        :path => /\/test\/\d+/,
        :handler => test_handler_two
      }, {
        :method => :get,
        :path => "/test/:id_one/path/:id_two",
        :handler => test_handler_three
      }
    ]
  end

  subject { described_class.new routes }

  before :each do
    test_handler_one.stub(:response).and_return(:test_response_one)
    test_handler_two.stub(:response).and_return(:test_response_two)
    test_handler_three.stub(:response).and_return(:test_response_three)
  end

  def environment(method, path)
    {
      "REQUEST_METHOD" => method.to_s.upcase,
      "PATH_INFO" => path
    }
  end

  describe "#dispatch" do

    it "should return the handler response if the given environment matches a route" do
      result = subject.dispatch environment(:get, "/test")
      result.should == :test_response_one
    end

    it "should match routes that defined via regular expressions" do
      result = subject.dispatch environment(:get, "/test/123")
      result.should == :test_response_two
    end

    it "should extract parameters from the route path and place it in the environment" do
      test_handler_three.should_receive(:response).with(
        hash_including("parameters" => { :id_one => "abc", :id_two => "def" }))
      result = subject.dispatch environment(:get, "/test/abc/path/def")
      result.should == :test_response_three
    end

    it "should return nil if the no route are matched" do
      result = subject.dispatch environment(:get, "/unhandled")
      result.should be_nil
    end

  end

end
