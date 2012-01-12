
class Holoserve::Tool::Hash::KeySymbolizer

  def initialize(hash_or_array)
    @hash_or_array = hash_or_array
  end

  def hash
    if @hash_or_array.is_a?(Hash)
      symbolize_keys @hash_or_array
    elsif @hash_or_array.is_a?(Array)
      symbolize_keys_of_all @hash_or_array
    else
      @hash_or_array
    end
  end

  private

  def symbolize_keys(hash)
    return nil unless hash.is_a?(Hash)
    result = { }
    hash.each do |key, value|
      result[ key.to_sym ] = if value.is_a?(Hash)
        symbolize_keys value
      elsif value.is_a?(Array)
        symbolize_keys_of_all value
      else
        value
      end
    end
    result
  end

  def symbolize_keys_of_all(array)
    return nil unless array.is_a?(Array)
    array.map do |item|
      if item.is_a?(Hash)
        symbolize_keys item
      elsif item.is_a?(Array)
        symbolize_keys_of_all item
      else
        item
      end
    end
  end

end