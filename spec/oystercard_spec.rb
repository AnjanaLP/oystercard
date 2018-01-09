require "oystercard"
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) {double :entry_station}

  it 'sets zero balance on new oystercard' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises error when balance excedes balance limit' do
      balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(balance_limit)
      error = "Balance limit of #{balance_limit} reached"
      expect{subject.top_up(1)}.to raise_error error
    end
  end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
 end

  describe '#touch_in' do

    it 'checks if oystercard is touched in'do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'returns an error if you have insufficient balance' do
      expect{subject.touch_in(entry_station)}.to raise_error 'insufficient balance to touch in'
    end

    it 'stores the entry station' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end


end

  describe '#touch_out'do
    it 'checks if oystercard is touched out'do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

  it 'deducts balance on touch out' do
    subject.top_up(Oystercard::MIN_FARE)
    subject.touch_in(entry_station)
    expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::MIN_FARE)
  end


end
