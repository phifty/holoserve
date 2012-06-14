
class Holoserve::Response::Selector

  class Sandbox

    def initialize(state, logger)
      @logger = logger
      state.each do |resource, value|
        define_singleton_method resource.to_sym do
          value ? value.to_sym : nil
        end
      end
    end

    def method_missing(method_name, *arguments, &block)
      @logger.warn "tried to use undefined state key '#{method_name}'"
      nil
    end

  end

  def initialize(responses, state, logger)
    @responses, @logger = responses, logger
    @sandbox = Sandbox.new state, logger
  end

  def default_response
    @responses[:default] ?
      @responses[:default] :
      { }
  end

  def selected_responses
    result = [ ]
    (@responses || { }).each do |key, response|
      next if key.to_s == "default"
      begin
        match = @sandbox.instance_eval do
          eval response[:condition].to_s
        end
        result << response if match
      rescue Object => error
        @logger.error error.inspect
      end
    end
    result
  end

  def find_variants
    result = [ ]
    @responses.each_key do |key|
      result << key
    end
    result
  end

end
