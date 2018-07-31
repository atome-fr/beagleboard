module BeagleBoard
  module Base
    class Adc
      attr_accessor :scale

      def initialize(_adc, scale = 2**12)
        @scale = scale

        enable unless enabled?
      end

      def enabled?
        raise StandardError, 'Not supported'
      end

      def enable
        raise StandardError, 'Not supported'
      end

      def disable
        raise StandardError, 'Not supported'
      end

      def raw_value
        raise StandardError, 'Not supported'
      end

      def value
        res = (raw_value.to_f * @scale / 2**12)
        case @scale
        when Integer then res.to_i
        when Float then res
        else raise("Unexpected type: #{@scale.class}")
        end
      end
    end
  end
end
