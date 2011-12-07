
class Application::Response::Composer

  def initialize(response)
    @response = response
  end

  def response_array
    [ status, headers, [ body ] ]
  end

  private

  def status
    @response[:status]
  end

  def headers
    @response[:headers] || { }
  end

  def body
    @response[:body]
  end

end
