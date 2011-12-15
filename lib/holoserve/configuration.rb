
class Holoserve::Configuration

  attr_reader :layouts
  attr_reader :layout_id

  def layouts=(hash)
    @layouts = Holoserve::Tool::Hash::KeySymbolizer.new(hash).hash
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

  def load_layouts_from_yml(filename)
    self.layouts = YAML::load filename
  rescue Psych::SyntaxError => error
    self.clear_layouts!
    raise error
  end

end
