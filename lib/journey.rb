class Journey
  attr_reader :entry_station, :exit_station

  def initialize
    @complete = false
  end

  def complete?
    @complete
  end

  def touch_in(station)
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
    if entry_station then @complete = true end 
  end
end
