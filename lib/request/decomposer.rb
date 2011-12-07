
class Application::Request::Decomposer

  def initialize(request)
    @request = request
  end

  def hash
    {
      :method => @request["REQUEST_METHOD"],
      :path => @request["PATH_INFO"]
    }
  end

end
