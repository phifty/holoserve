
class Holoserve::Response::Combiner

  def initialize(responses, situation)
    @responses, @situation = responses, situation
  end

  def response
    Holoserve::Tool::Merger.new(default_response, situation_response).result
  end

  private

  def default_response
    @responses[:default] ?
      @responses[:default] :
      { }
  end

  def situation_response
    @situation && @responses[@situation.to_sym] ?
      @responses[@situation.to_sym] :
      { }
  end

end
