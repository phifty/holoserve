
class Holoserve::Tool::DataPath

  PATH_SEPARATOR = ".".freeze unless defined?(PATH_SEPARATOR)

  attr_accessor :path
  attr_accessor :data

  def initialize(path, data)
    @path, @data = path, data
  end

  def fetch
    path = @path ? @path.split(PATH_SEPARATOR) : [ ]
    return @data if path.empty?

    selected = @data
    key = parse_key path.shift

    while path.length > 0
      return nil unless selected.respond_to?(:[])
      selected = selected[key]

      key = parse_key path.shift
    end

    return nil unless selected.respond_to?(:[])
    selected[key]
  end

  def store(value)
    path = @path ? @path.split(PATH_SEPARATOR) : [ ]
    return Holoserve::Tool::Merger.new(@data, value).result if path.empty?

    result = selected = clone @data
    key = parse_key path.shift

    while path.length > 0
      break unless selected.respond_to?(:[])

      selected[key] ||= { }
      selected = selected[key]
      key = parse_key path.shift
    end

    selected[key] = value
    result
  end

  private

  def parse_key(key)
    key =~ /^\d+$/ ? key.to_i : key.to_sym
  end

  def clone(object)
    Marshal.load Marshal.dump(object)
  end

end
