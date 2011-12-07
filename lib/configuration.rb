
class Configuration

  attr_accessor :layouts
  attr_accessor :layout

  def clear_layouts!
    self.layouts = nil
  end

  def layout_ids
    self.layouts ? self.layouts.keys : [ ]
  end

end
