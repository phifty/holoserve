
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
      Holoserve::Fixture::Importer.new(@responses[:default], fixtures).result :
      { }
  end

  def situation_response
    situation && @responses[situation.to_sym] ?
      Holoserve::Fixture::Importer.new(@responses[situation.to_sym], fixtures).result :
      { }
  end
  
  def fixtures
    @configuration[:fixtures]
  end

  def situation
    @configuration[:situation]
  end

end
