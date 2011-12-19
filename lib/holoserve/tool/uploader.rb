require 'transport'

class Holoserve::Tool::Uploader

  def initialize(filename, http_method, url, options = { })
    @filename, @http_method, @url, @options = filename, http_method, url, options
  end

  def upload
    options = @options
    options[:headers] = (@options[:headers] || { }).merge(headers)
    options[:body] = body
    Transport::HTTP.request @http_method, @url, options
  end

  private

  def headers
    { "Content-Type" => "multipart/form-data, boundary=#{boundary}" }
  end

  def body
    "--#{boundary}\r\n" +
    "Content-Disposition: form-data; name=\"file\"; filename=\"#{File.basename(@filename)}\"\r\n" +
    "Content-Type: application/x-yaml\r\n" +
    "\r\n" +
    File.read(@filename) +
    "\r\n" +
    "--#{boundary}--\r\n"
  end

  def boundary
    "xxx12345xxx"
  end

end
