require 'beaglebone'

RSpec.describe BeagleBone do
  it 'should provide wrappers' do
    expect(subject).to receive(:gpio1_22)

    subject.usr1
  end
end
