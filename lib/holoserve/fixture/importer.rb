
class Holoserve::Fixture::Importer

  attr_accessor :hash
  attr_accessor :fixtures

  def initialize(hash, fixtures)
    @hash, @fixtures = hash, fixtures
  end

  def result
    @result = { }
    import
    merge
    @result
  end

  private

  def import
    imports.each do |import|
      path, as, only = *import.values_at(:path, :as, :only)

      value = Holoserve::Tool::DataPath.new(path, @fixtures).fetch

      value = value.reject{ |key, v| ![ only ].flatten.compact.include?(key.to_s) } if only && value.respond_to?(:reject)

      @result = Holoserve::Tool::DataPath.new(as, @result || { }).store value
    end
  end

  def merge
    @result = Holoserve::Tool::Merger.new(@result, hash_without_imports).result
  end

  def hash_without_imports
    @hash.reject{ |key, v| key == :imports }
  end

  def imports
    @hash[:imports] || [ ]
  end

end
