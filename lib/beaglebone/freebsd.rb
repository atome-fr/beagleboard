require 'ffi'

module BeagleBone
  extend FFI::Library
  ffi_lib 'gpio'
  attach_function :gpio_open, [:int], :int
  attach_function :gpio_open_device, [:string], :int
  attach_function :gpio_close, [:int], :void

  attach_function :gpio_pin_high, [:int, :uint32], :int
  attach_function :gpio_pin_low, [:int, :uint32], :int
end
