
class Holoserve::Response::Combiner

  def initialize(default, responses)
    @default, @responses = default, responses
  end

  def response
    @responses.inject @default do |result, response|
      Holoserve::Tool::Merger.new(result, response).result
    end
  end

end
