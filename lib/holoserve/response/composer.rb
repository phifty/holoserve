require 'json'

class Holoserve::Response::Composer

  def initialize(response)
    @response = response
  end

  def response_array
    [ status, headers, [ body ] ]
  end

  private

  def status
    @response[:status] || 200
  end

  def headers
    @response[:headers] || { }
  end

  def body
    @body ||= begin
      if @response.has_key?(:body)
        @response[:body]
      elsif @response.has_key?(:json)
        JSON.dump @response[:json]
      else
        ""
      end
    end
  end

end
