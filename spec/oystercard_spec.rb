require "oystercard"
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) {double :entry_station}
  let(:exit_station) { double :exit_station }

  describe '#initialize' do
    it 'sets zero balance on new oystercard' do
      expect(subject.balance).to eq 0
    end
    it 'starts with empty journey log' do
      expect(subject.journeys).to be_empty
    end
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
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

  describe '#touch_in' do
    context 'card topped up and touched in' do
      before do
        subject.top_up(Oystercard::MIN_FARE)
        subject.touch_in(entry_station)
      end
      it 'checks if oystercard is touched in'do
        expect(subject).to be_in_journey
      end
      it 'stores the entry station' do
        expect(subject.entry_station).to eq entry_station
      end
      it 'changes card status to in journey' do
        expect(subject).to be_in_journey
      end
    end
    it 'returns an error if you have insufficient balance' do
      expect{subject.touch_in(entry_station)}.to raise_error 'insufficient balance to touch in'
    end
end

describe '#touch_out'do
    context 'card topped up and touched in' do
      before do
        subject.top_up(Oystercard::MIN_FARE)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      end
      it 'checks if oystercard is touched out'do
        expect(subject).not_to be_in_journey
      end
      it 'stores an exit station' do
        expect(subject.exit_station).to eq exit_station
      end
      it 'stores a completed journey' do
        expect(subject.journeys).to eq [{ entry: entry_station, exit:exit_station }]
      end
    end
  end
  it 'deducts balance on touch out' do
    subject.top_up(Oystercard::MIN_FARE)
    subject.touch_in(entry_station)
    expect {subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MIN_FARE)
  end
end
