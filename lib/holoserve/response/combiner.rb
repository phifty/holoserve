
class Holoserve::Response::Combiner

  class Sandbox

    def initialize(state)
      state.each do |resource, state|
        define_singleton_method resource.to_sym do
          state
        end
      end
    end

  end

  def initialize(responses, state, logger)
    @responses, @logger = responses, logger
    @sandbox = Sandbox.new state
  end

  def response
    matching_responses.inject default_response do |result, response|
      Holoserve::Tool::Merger.new(result, response).result
    end
  end

  private

  def default_response
    @responses[:default] ?
      @responses[:default] :
      { }
  end

  def matching_responses
    result = [ ]
    (@responses || { }).each do |line, response|
      next if line.to_s == "default"
      begin
        match = @sandbox.instance_eval do
          eval line.to_s
        end
        result << response if match
      rescue Object => error
        @logger.error error.inspect
      end
    end
    result
  end

end
