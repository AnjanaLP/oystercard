class Oystercard
attr_reader :balance
attr_accessor :in_journey
attr_reader :entry_station, :journeys

BALANCE_LIMIT = 90
MIN_FARE = 1

  def initialize
   @balance = 0
   @entry_station = nil
   @journeys = []
  end

  def top_up(amount)
    raise "Balance limit of #{BALANCE_LIMIT} reached" if amount +balance > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
   !!@entry_station
  end

  def touch_in(entry_station)
    raise 'insufficient balance to touch in' if balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journeys << {entry: @entry_station, exit: exit_station}
    @entry_station = nil
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
