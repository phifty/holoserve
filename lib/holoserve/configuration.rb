require 'yaml'

class Holoserve::Configuration

  attr_reader :logger

  attr_reader :layouts
  attr_reader :layout_id

  def initialize(logger)
    @logger = logger
  end

  def layouts=(hash)
    @layouts = Holoserve::Tool::Hash::KeySymbolizer.new(hash).hash
  end

  def layout_id=(value)
    @layout_id = value.to_sym
    logger.info "made '#{value}' the current layout"
  end

  def clear_layouts!
    self.layouts = nil
  end

  def layout
    self.layouts ? self.layouts[self.layout_id] : nil
  end

  def load_layouts_from_yml_file(file)
    self.layouts = YAML::load_file file
    logger.info "loaded layouts from file #{file.path}"
  rescue Psych::SyntaxError => error
    self.clear_layouts!
    raise error
  end

end
