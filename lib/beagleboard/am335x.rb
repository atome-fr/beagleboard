require 'ffi'

require "beagleboard/#{FFI::Platform::OS}/adc"
require "beagleboard/#{FFI::Platform::OS}/gpio"

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
      instance_variable_set("@#{name}", ain_factory(name))

      define_singleton_method(name) do
        instance_variable_get("@#{name}")
      end
      send(name)
    elsif valid_gpio_name(name)
      instance_variable_set("@#{name}", gpio_factory(name))

      define_singleton_method(name) do
        instance_variable_get("@#{name}")
      end
      send(name)
    else
      super
    end
  end

  private

  def valid_ain_name(name)
    return nil unless (captures = name.to_s.match(/\Aain(\d)\z/))
    return nil unless (0...7).cover?(captures[1].to_i)
    captures[1].to_i
  end

  def ain_factory(name)
    ain = valid_ain_name(name)

    Object.const_get("#{@plateform}::Adc").new(ain)
  end

  def valid_gpio_name(name)
    return nil unless (captures = name.to_s.match(/\Agpio(\d)_([1-9][0-9]*)\z/))
    return nil unless (0..3).cover?(captures[1].to_i)
    return nil unless (0...32).cover?(captures[2].to_i)
    [captures[1].to_i, captures[2].to_i]
  end

  def gpio_factory(name)
    bank, gpio = valid_gpio_name(name)

    Object.const_get("#{@plateform}::Gpio").new(bank, gpio)
  end
end
