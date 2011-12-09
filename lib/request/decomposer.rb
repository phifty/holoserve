
class Request::Decomposer

  def initialize(request)
    @request = request
  end

  def hash
    hash = {
      :method => @request["REQUEST_METHOD"],
      :path => @request["PATH_INFO"]
    }
    hash.merge! :headers => headers unless headers.empty?
    hash.merge! :body => body unless body.nil?
    hash.merge! :parameters => parameters unless parameters.empty?
    hash
  end

  private

  def headers
    headers = { }
    @request.each do |key, value|
      headers[ key.to_sym ] = value unless key =~ /^rack\./
    end
    headers
  end

  def body
    @body ||= begin
      body = @request["rack.input"].read
      body && body != "" ? body : nil
    end
  end

  def parameters
    Tool::Hash::KeySymbolizer.new(query_hash.merge(form_hash)).hash
  end

  def query_hash
    @request["rack.request.query_hash"] || { }
  end

  def form_hash
    @request["rack.request.form_hash"] || { }
  end

end
