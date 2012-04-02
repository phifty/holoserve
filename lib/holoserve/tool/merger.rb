
class Holoserve::Tool::Merger

  def initialize(hash_or_array_one, hash_or_array_two)
    @hash_or_array_one, @hash_or_array_two = hash_or_array_one, hash_or_array_two
  end

  def result
    if @hash_or_array_one.is_a?(Hash) && @hash_or_array_two.is_a?(Hash)
      merged_hash
    elsif @hash_or_array_one.is_a?(Array) && @hash_or_array_two.is_a?(Array)
      merged_array
    else
      @hash_or_array_two
    end
  end

  private

  def merged_hash
    result = { }
    (@hash_or_array_one.keys + @hash_or_array_two.keys).uniq.each do |key|
      value_one, value_two = @hash_or_array_one[key], @hash_or_array_two[key]
      result[key] = if values_mergeable?(value_one, value_two)
        self.class.new(value_one, value_two).result
      else
        @hash_or_array_two.has_key?(key) ? value_two : value_one
      end
    end
    result
  end

  def merged_array
    result = Array.new [ @hash_or_array_one.length, @hash_or_array_two.length ].max
    result.each_index do |index|
      value_one, value_two = @hash_or_array_one[index], @hash_or_array_two[index]
      result[index] = if values_mergeable?(value_one, value_two)
        self.class.new(value_one, value_two).result
      else
        index < @hash_or_array_two.length ? value_two : value_one
      end
    end
    result
  end

  def values_mergeable?(value_one, value_two)
    (value_one.is_a?(Hash) && value_two.is_a?(Hash)) ||
      (value_one.is_a?(Array) && value_two.is_a?(Array))
  end

end
