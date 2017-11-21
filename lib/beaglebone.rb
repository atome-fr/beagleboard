require 'ffi'

require "beaglebone/#{FFI::Platform::OS}"

x = BeagleBone.gpio_open(1)
10_000.times do
  BeagleBone.gpio_pin_high(x, 21)
  BeagleBone.gpio_pin_high(x, 22)
  BeagleBone.gpio_pin_high(x, 23)
  BeagleBone.gpio_pin_high(x, 24)
  sleep(0.2)
  BeagleBone.gpio_pin_low(x, 21)
  BeagleBone.gpio_pin_low(x, 22)
  BeagleBone.gpio_pin_low(x, 23)
  BeagleBone.gpio_pin_low(x, 24)
  sleep(0.2)
end
BeagleBone.gpio_close(x)

__END__

gpio = BeagleBone.gpio(:P9_12)
gpio.high
gpio.low

module BeagleBone
  class GPIO
  end
end
