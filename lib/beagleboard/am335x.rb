require 'ffi'

require "beagleboard/#{FFI::Platform::OS}/adc"
require "beagleboard/#{FFI::Platform::OS}/gpio"

module BeagleBoard
  class AM335x
    def initialize
      @plateform = case FFI::Platform::OS
                   when 'linux' then 'Linux'
                   when 'freebsd' then 'FreeBSD'
                   end
    end

    def respond_to_missing?(name, *args)
      return true if valid_ain_name(name)
      return true if valid_gpio_name(name)
      super
    end

    def method_missing(name, *args)
      if valid_ain_name(name)
        attach_object(name, ain_factory(name))
      elsif valid_gpio_name(name)
        attach_object(name, gpio_factory(name))
      else
        super
      end
    end

    private

    def attach_object(name, obj)
      instance_variable_set("@#{name}", obj)

      define_singleton_method(name) do
        instance_variable_get("@#{name}")
      end

      obj
    end

    def valid_ain_name(name)
      return nil unless (captures = name.to_s.match(/\Aain(\d)\z/))
      return nil unless (0...7).cover?(captures[1].to_i)
      captures[1].to_i
    end

    def ain_factory(name)
      ain = valid_ain_name(name)

      Object.const_get("BeagleBoard::#{@plateform}::Adc").new(ain)
    end

    def valid_gpio_name(name)
      return nil unless (captures = name.to_s.match(/\Agpio(\d)_(\d|[1-9]\d+)\z/))
      return nil unless (0..3).cover?(captures[1].to_i)
      return nil unless (0...32).cover?(captures[2].to_i)
      [captures[1].to_i, captures[2].to_i]
    end

    def gpio_factory(name)
      bank, gpio = valid_gpio_name(name)

      Object.const_get("BeagleBoard::#{@plateform}::Gpio").new(bank, gpio)
    end
  end
end
