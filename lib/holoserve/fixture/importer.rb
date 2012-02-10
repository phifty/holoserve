
class Holoserve::Fixture::Importer

  attr_accessor :fixtures

  def initialize(hash, fixtures)
    @fixtures = fixtures
    self.hash = hash
  end

  def hash=(value)
    @hash = value.dup if value
    @imports = @hash.respond_to?(:delete) && @hash.delete(:imports) || [ ]
  end

  def hash
    import
    merge
    @result
  end

  private

  def import
    @imports.each do |import|
      path, as, only = *import.values_at(:path, :as, :only)

      value = Holoserve::Tool::DataPath.new(path, @fixtures).fetch

      value.delete_if do |key, v|
        ![ only ].flatten.compact.include?(key.to_s)
      end if only.respond_to?(:include?) && value.respond_to?(:delete_if)

      @result = Holoserve::Tool::DataPath.new(as, @result || { }).store value
    end
  end

  def merge
    @result = Holoserve::Tool::Merger.new(@result, @hash).result if @hash
  end

end
