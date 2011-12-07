
class Configuration

  attr_reader :layouts
  attr_reader :layout_id

  def layouts=(hash)
    @layouts = Tool::Hash::KeySymbolizer.new(hash).hash
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

end
