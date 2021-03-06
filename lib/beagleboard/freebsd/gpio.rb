require 'ffi'

require 'beagleboard/base/gpio'

module BeagleBoard
  module FreeBSD
    class Gpio < BeagleBoard::Base::Gpio
      extend FFI::Library

      GPIO_PIN_LOW  = 0x00
      GPIO_PIN_HIGH = 0x01

      GPIO_PIN_INPUT     = 0x001
      GPIO_PIN_OUTPUT    = 0x002
      GPIO_PIN_OPENDRAIN = 0x004
      GPIO_PIN_PUSHPULL  = 0x008
      GPIO_PIN_TRISTATE  = 0x010
      GPIO_PIN_PULLUP    = 0x020
      GPIO_PIN_PULLDOWN  = 0x040
      GPIO_PIN_INVIN     = 0x080
      GPIO_PIN_INVOUT    = 0x100

      GPIO_VALUE_INVALID = -1
      GPIO_VALUE_LOW     = GPIO_PIN_LOW
      GPIO_VALUE_HIGH    = GPIO_PIN_HIGH

      ffi_lib 'gpio'
      attach_function :gpio_open, [:int], :int
      attach_function :gpio_open_device, [:string], :int
      attach_function :gpio_close, [:int], :void
      # gpio_pin_list
      # gpio_pin_config
      # gpio_pin_set_name
      attach_function :gpio_pin_get, %i[int uint32], :int
      attach_function :gpio_pin_set, %i[int uint32 int], :int
      attach_function :gpio_pin_toggle, %i[int uint32], :int
      attach_function :gpio_pin_low, %i[int uint32], :int
      attach_function :gpio_pin_high, %i[int uint32], :int
      attach_function :gpio_pin_input, %i[int uint32], :int
      attach_function :gpio_pin_output, %i[int uint32], :int
      attach_function :gpio_pin_opendrain, %i[int uint32], :int
      attach_function :gpio_pin_pushpull, %i[int uint32], :int
      attach_function :gpio_pin_tristate, %i[int uint32], :int
      attach_function :gpio_pin_pullup, %i[int uint32], :int
      attach_function :gpio_pin_pulldown, %i[int uint32], :int
      attach_function :gpio_pin_invin, %i[int uint32], :int
      attach_function :gpio_pin_invout, %i[int uint32], :int
      attach_function :gpio_pin_pulsate, %i[int uint32], :int

      def initialize(bank, gpio)
        super
      end

      def open
        @bank_fd = gpio_open(@bank)
      end

      def close
        gpio_close(@bank_fd)
      end

      def toggle
        gpio_pin_toggle(@bank_fd, @gpio)
      end

      def direction
        case gpio_pin_config(@bank_fd, @gpio)
        when GPIO_PIN_INPUT then :in
        when GPIO_PIN_OUTPUT then :out
        end
      end

      def direction=(direction)
        send(direction_function(direction), @bank_fd, @gpio)
        self.value = direction_value(direction)
      end

      def value
        res = Gpio.gpio_pin_get(@bank_fd, @gpio)

        raise 'Read error' if res < 0

        res
      end

      def value=(value)
        return unless value
        res = send(value_function(value), @bank_fd, @gpio)
        raise StandardError, 'Write error' if res < 0
      end

      private

      def direction_function(direction)
        {
          in: :gpio_pin_input,
          out: :gpio_pin_output,
          low: :gpio_pin_output,
          high: :gpio_pin_output
        }[direction]
      end

      def direction_value(direction)
        {
          in: nil,
          out: nil,
          low: 0,
          high: 1
        }[direction]
      end

      def value_function(value)
        {
          0   => :gpio_pin_low,
          1   => :gpio_pin_high,
          nil => nil
        }[value]
      end
    end
  end
end
