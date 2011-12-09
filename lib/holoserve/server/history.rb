
class Holoserve::Server::History

  attr_reader :pair_names

  def initialize
    @pair_names = [ ]
  end

  def clear!
    @pair_names.clear
  end

end
