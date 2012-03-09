
class Holoserve::Response::Selector

  class Sandbox

    def initialize(state)
      state.each do |resource, value|
        define_singleton_method resource.to_sym do
          value
        end
      end
    end

  end

  def initialize(responses, state, logger)
    @responses, @logger = responses, logger
    @sandbox = Sandbox.new state
  end

  def default_response
    @responses[:default] ?
      @responses[:default] :
      { }
  end

  def selected_responses
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
