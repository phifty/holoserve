
class Holoserve::Data::Builder

  attr_accessor :outline
  attr_accessor :fixtures

  def initialize(outline, fixtures)
    @outline, @fixtures = outline, fixtures
  end

  def data
    import
    merge
    @result
  end

  private

  def import
    (@outline[:imports] || [ ]).each do |import|
      value = Holoserve::Tool::DataPath.new(import[:path], @fixtures).fetch
      @result = if import[:as]
        Holoserve::Tool::DataPath.new(import[:as], @result || { }).store value
      else
        value
      end
    end
  end

  def merge
    @result = Holoserve::Tool::Merger.new(@result, @outline[:data]).result if @outline[:data]
  end

end
