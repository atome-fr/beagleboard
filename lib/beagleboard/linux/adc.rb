require 'beagleboard/base/adc'

module BeagleBone
module Linux
  class Adc < BeagleBone::Base::Adc
    def initialize(ain)
      @ain_number = ain

      super
    end

    def enable; end

    def disable; end

    def raw_value
      File.read("/sys/bus/iio/devices/iio:device0/in_voltage#{@ain_number}_raw")
    end
  end
end
end
