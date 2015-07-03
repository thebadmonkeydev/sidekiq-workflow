class Sidekiq::Workflow::Monitor
  attr_accessor :wid
  def self.[](wid)
    self.new(wid)
  end

  def initialize(wid)
    self.wid = wid
  end

end
