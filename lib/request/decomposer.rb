
class Application::Request::Decomposer

  def initialize(request)
    @request = request
  end

  def hash
    hash = {
      :method => @request["REQUEST_METHOD"],
      :path => @request["PATH_INFO"]
    }
    hash.merge! :parameters => parameters unless parameters.empty?
    hash
  end

  private

  def parameters
    Application::Hash::KeySymbolizer.new(query_hash.merge(form_hash)).hash
  end

  def query_hash
    @request["rack.request.query_hash"] || { }
  end

  def form_hash
    @request["rack.request.form_hash"] || { }
  end

end
