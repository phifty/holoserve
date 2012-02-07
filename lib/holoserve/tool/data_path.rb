
class Holoserve::Tool::DataPath

  attr_accessor :path
  attr_accessor :data

  def initialize(path, data)
    @path, @data = path, data
  end

  def fetch
    fetch_in @path.split("."), @data
  end

  private

  def fetch_in(path, data)
    return data if path.empty?
    key = path.shift
    value = data[ key =~ /^\d+$/ ? key.to_i : key.to_sym ]
    path.empty? ?
      value :
      (value.respond_to?(:[]) ?
        fetch_in(path, value) :
        nil)
  end

end
