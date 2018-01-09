require 'journey'

describe Journey do
  let(:entry_station){ double :station }
  let(:exit_station){double :station }

  subject { described_class.new }

  describe '#initialize' do
    it 'journey is incomplete' do
      expect(subject).not_to be_complete
    end
  end

  describe '#touch_in' do
    it 'stores the entry station' do
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do
    it 'stores the exit station' do
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
    context 'complete journeys with entry station' do
      it 'confirms complete journey' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject).to be_complete
      end
    end
    context 'incomplete journey without entry_station' do
        it 'journey should not be complete' do
        subject.touch_out(exit_station)
        expect(subject).not_to be_complete
      end 
    end
  end

end
