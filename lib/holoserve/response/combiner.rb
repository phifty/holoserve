
class Holoserve::Response::Combiner

  def initialize(responses, configuration)
    @responses, @configuration = responses, configuration
  end

  def response
    Holoserve::Tool::Merger.new(default_response, situation_response).result
  end

  private

  def default_response
    @responses[:default] ?
      Holoserve::Data::Builder.new(@responses[:default], fixtures).data :
      { }
  end

  def situation_response
    situation && @responses[situation.to_sym] ?
      Holoserve::Data::Builder.new(@responses[situation.to_sym], fixtures).data :
      { }
  end
  
  def fixtures
    @configuration[:fixtures]
  end

  def situation
    @configuration[:situation]
  end

end
