module Base
  class Gpio
    def initialize(bank, gpio)
      @bank = bank
      @gpio = gpio
      open
    end

    def open; end

    def close; end

    def direction
      raise StandardError, 'Not supported'
    end

    def direction=(value)
      raise StandardError, 'Invalid direction' unless %i[in out low high].include?(value)

      value.to_s
    end

    def value
      raise StandardError, 'Not supported'
    end

    def value=(_value)
      raise StandardError, 'Not supported'
    end
  end
end
