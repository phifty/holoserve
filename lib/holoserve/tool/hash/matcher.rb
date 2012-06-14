
class Holoserve::Tool::Hash::Matcher

  attr_accessor :hash
  attr_accessor :subset

  def initialize(hash, subset)
    @hash, @subset = hash, subset
  end

  def match?
    return false if @hash.length < @subset.length
    @subset.each do |key, value|
      if @hash.has_key?(key)
        return false unless match_value?(@hash[key], value)
      else
        return false
      end
    end
    true
  end

  private

  def match_value?(value_one, value_two)
    if value_one.is_a?(Hash) && value_two.is_a?(Hash)
      return false unless match_hash?(value_one, value_two)
    elsif value_one.is_a?(Array) && value_two.is_a?(Array)
      return false unless match_array?(value_one, value_two)
    else
      return false unless value_one == value_two
    end
    true
  end

  def match_hash?(hash, subset)
    tmp = Holoserve::Tool::Hash::Matcher.new(hash, subset)
    return false unless tmp.match?
    true
  end

  def match_array?(array, subset)
    return false if array.length < subset.length
    subset.each_index do |i|
      if subset[i].is_a?(Hash) && array[i].is_a?(Hash)
        return false unless match_hash?(array[i], subset[i])
      elsif subset[i].is_a?(Array) && array[i].is_a?(Array)
        return false unless match_array?(array[i], subset[i])
      end
    end
    true
  end
end
