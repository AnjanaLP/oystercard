class Oystercard
attr_reader :balance
BALANCE_LIMIT = 90
  def initialize
   @balance = 0
  end

  def top_up(amount)
    raise "Balance limit of #{BALANCE_LIMIT} reached" if amount +balance > BALANCE_LIMIT
    @balance += amount
  end
end
