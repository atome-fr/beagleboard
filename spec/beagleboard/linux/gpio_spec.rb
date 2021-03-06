require 'beagleboard/linux/gpio'

RSpec.describe BeagleBoard::Linux::Gpio do
  subject do
    BeagleBoard::Linux::Gpio.new(1, 23)
  end

  it 'has the expected Linux GPIO call path' do
    expect(File).to receive(:write).with('/sys/class/gpio/export', '55')
    expect(File).to receive(:read).with('/sys/class/gpio/gpio55/value')

    subject.value
  end
end
