
class Holoserve::Fixture::Importer

  attr_accessor :fixtures

  def initialize(hash, fixtures)
    @fixtures = fixtures
    self.hash = hash
  end

  def hash=(value)
    @imports = value.respond_to?(:delete) && value.delete(:imports) || [ ]
    @hash = value
  end

  def hash
    import
    merge
    @result
  end

  private

  def import
    @imports.each do |import|
      path = import[:path]
      as = import[:as] || path
      value = Holoserve::Tool::DataPath.new(path, @fixtures).fetch
      @result = Holoserve::Tool::DataPath.new(as, @result || { }).store value
    end
  end

  def merge
    @result = Holoserve::Tool::Merger.new(@result, @hash).result if @hash
  end

end
