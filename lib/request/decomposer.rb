
class Request::Decomposer

  def initialize(request)
    @request = request
  end

  def hash
    hash = {
      :method => @request["REQUEST_METHOD"],
      :path => @request["PATH_INFO"]
    }
    hash.merge! :parameters => parameters unless parameters.empty?
    hash.merge! :headers => headers unless headers.empty?
    hash
  end

  private

  def parameters
    Tool::Hash::KeySymbolizer.new(query_hash.merge(form_hash)).hash
  end

  def query_hash
    @request["rack.request.query_hash"] || { }
  end

  def form_hash
    @request["rack.request.form_hash"] || { }
  end

  def headers
    headers = { }
    headers[:"Content-Type"] = @request["CONTENT_TYPE"] if @request["CONTENT_TYPE"]
    headers
  end

end
