require 'beagleboard/freebsd/gpio'

RSpec.describe BeagleBoard::FreeBSD::Gpio do
  subject do
    expect_any_instance_of(BeagleBoard::FreeBSD::Gpio).to receive(:gpio_open).with(1).and_return(9)
    BeagleBoard::FreeBSD::Gpio.new(1, 23)
  end

  it 'has the expected FreeBSD GPIO call path' do
    expect(subject).to receive(:gpio_pin_get).with(9, 23).and_return(1)

    expect(subject.value).to eq(1)
  end
end
