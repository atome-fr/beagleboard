require 'beagleboard/beaglebone'

RSpec.describe BeagleBoard::BeagleBone do
  context '.usr1' do
    it 'calls the wrapper' do
      expect(subject).to receive(:gpio1_22)

      subject.usr1
    end
  end

  it { is_expected.to_not respond_to(:p9_41) }
  it { is_expected.to respond_to(:p9_42) }
  it { is_expected.to_not respond_to(:p9_41a) }
  it { is_expected.to_not respond_to(:p9_41b) }
  it { is_expected.to_not respond_to(:p9_42a) }
  it { is_expected.to_not respond_to(:p9_42b) }
end
