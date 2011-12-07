
class Configuration

  attr_reader :layouts
  attr_reader :layout_id

  def layouts=(hash)
    @layouts = symbolize_keys hash
  end

  def layout_id=(value)
    @layout_id = value.to_sym
  end

  def clear_layouts!
    self.layouts = nil
  end

  def layout_ids
    self.layouts ? self.layouts.keys : [ ]
  end

  def layout_id?(id)
    self.layout_ids.include? id.to_sym
  end

  def layout
    self.layouts ? self.layouts[self.layout_id] : nil
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
