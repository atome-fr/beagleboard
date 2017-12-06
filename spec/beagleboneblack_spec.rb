require 'beagleboard/beagleboneblack'

RSpec.describe BeagleBoard::BeagleBoneBlack do
  context 'without capes' do
    subject do
      BeagleBoard::BeagleBoneBlack.new(capes: [])
    end

    it 'should allow access to EMMC GPIO' do
      expect(subject).to receive(:gpio1_5)
      subject.p8_22
    end
  end

  it 'should not allow access to EMMC GPIO' do
    expect { subject.p8_22 }.to raise_error(StandardError, 'Pin disabled (MMC)')
  end

  context '.p9_41' do
    let(:p9_41a) { double }
    let(:p9_41b) { double }

    it { is_expected.to respond_to(:p9_41a) }
    it { is_expected.to respond_to(:p9_41b) }

    it 'has a proper call sequence' do
      expect(subject).to receive(:p9_41a).and_return(p9_41a)
      expect(p9_41a).to receive(:direction=).with(:in)
      expect(subject).to receive(:p9_41b).and_return(p9_41b)

      expect(subject.p9_41).to be p9_41b
    end
  end

  context '.p9_42' do
    let(:p9_42a) { double }
    let(:p9_42b) { double }

    it { is_expected.to respond_to(:p9_42a) }
    it { is_expected.to respond_to(:p9_42b) }

    it 'has a proper call sequence' do
      expect(subject).to receive(:p9_42a).and_return(p9_42a)
      expect(p9_42a).to receive(:direction=).with(:in)
      expect(subject).to receive(:p9_42b).and_return(p9_42b)

      expect(subject.p9_42).to be p9_42b
    end
  end
end
