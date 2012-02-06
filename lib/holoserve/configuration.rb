require 'yaml'

class Holoserve::Configuration

  class InvalidFormatError < StandardError; end

  attr_reader :logger

  attr_reader :situation
  attr_accessor :pairs

  def initialize(logger)
    @logger = logger
    @pairs = { }
  end

  def situation=(value)
    @situation = value.to_sym
    logger.info "made '#{value}' the current situation"
  end

  def clear_situation!
    @situation = nil
    logger.info "cleared the current situation"
  end

end
