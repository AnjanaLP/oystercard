require 'station'

describe Station do
  subject {described_class.new('Kings Cross', 4 )}

  describe '#initialize' do

    it 'sets station name' do
      expect(subject.name).to eq('Kings Cross')
    end

    it 'sets the zone' do
      expect(subject.zone).to eq(4)
    end
 end

end
