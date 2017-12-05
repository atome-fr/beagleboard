require 'ffi'

require 'beagleboard/base/adc'

FFI.typedef(:uint32, :size_t)

module FreeBSD
  class Adc < Base::Adc
    extend FFI::Library
    ffi_lib 'c'
    attach_function :sysctl, [:pointer, :uint, :pointer, :pointer, :pointer, :size_t], :int
    attach_function :sysctlbyname, [:string, :pointer, :pointer, :pointer, :size_t], :int
    attach_function :sysctlnametomib, [:string, :pointer, :pointer], :int

    def self.enable(mib)
      buf = FFI::MemoryPointer.new(:int).write_int(1)
      sysctl(mib, 6, nil, nil, buf, buf.size)
    end

    def self.disable(mib)
      buf = FFI::MemoryPointer.new(:int).write_int(0)
      sysctl(mib, 6, nil, nil, buf, buf.size)
    end

    def self.input(mib)
      buf = FFI::MemoryPointer.new(:int)
      bufsiz = FFI::MemoryPointer.new(:int).write_int(buf.size)
      sysctl(mib, 6, buf, bufsiz, nil, 0)
      buf.read_int
    end

    def initialize(adc)
      @enable_mib = FFI::MemoryPointer.new(:int, 6)
      @input_mib = FFI::MemoryPointer.new(:int, 6)

      size = FFI::MemoryPointer.new(:int).write_int(6)
      Adc.sysctlnametomib("dev.ti_adc.0.ain.#{adc}.enable", @enable_mib, size)
      Adc.sysctlnametomib("dev.ti_adc.0.ain.#{adc}.input", @input_mib, size)

      super
    end

    def enable
      Adc.enable(@enable_mib)
    end

    def disable
      Adc.disable(@enable_mib)
    end

    def raw_value
      Adc.input(@input_mib)
    end

    attr_accessor :scale
  end
end
