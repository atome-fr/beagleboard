# beaglebone

A Ruby gem to manipulate the BeagleBone and BeagleBone Black ADC and GPIOs

## usage

```ruby
require 'beaglebone'

device = BeagleBoneBlack.new

# ADCs access
device.p9_39.scale = 100
device.p9_39.raw_value   #=> 2559
device.p9_39.value       #=> 62
device.p9_39.scale = 1.0
device.p9_39.value       #=> 0.624755859375

# GPIO access
device.p8_20.direction = :in
device.p8_20.value            #=> 0 or 1
device.p8_21.direction = :out
device.p8_21.value = 0

# Helpers for setting direction and value 
device.p8_22.direction = :low
device.p8_22.direction = :high

# USR LEDs access (they are GPIO)
10.times do
  device.usr0.value = 1
  sleep 0.1
  device.usr0.value = 0
  sleep 0.1
end
```
