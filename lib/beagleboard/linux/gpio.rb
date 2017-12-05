require 'beagleboard/base/gpio'

module Linux
  class Gpio < Base::Gpio
    def initialize(bank, gpio)
      @gpio_number = bank * 32 + gpio
      @gpio_directory = "/sys/class/gpio/gpio#{@gpio_number}"
      super
    end

    def open
      File.write('/sys/class/gpio/export', @gpio_number.to_s)
    end

    def close
      File.write('/sys/class/gpio/unexport', @gpio_number.to_s)
    end

    def direction
      File.read("#{@gpio_directory}/direction").to_sym
    end

    def direction=(value)
      raise StandardError, 'Invalid direction' unless %i[in out low high].include?(value)

      File.write("#{@gpio_directory}/direction", value.to_s)
    end

    def value
      File.read("#{@gpio_directory}/value").to_i
    end

    def value=(value)
      File.write("#{@gpio_directory}/value", value.to_s)
    end
  end
end
