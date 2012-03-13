
class Holoserve::State::Updater

  def initialize(state, transitions)
    @state, @transitions = state, transitions
  end

  def perform
    (@transitions || { }).each do |resource, value|
      @state[resource] = value
    end
  end

end
