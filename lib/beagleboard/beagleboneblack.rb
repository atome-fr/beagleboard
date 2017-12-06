require 'beagleboard/beaglebone'

module BeagleBoard
  module Cape
    module Emmc
      [(3..6).to_a, (20..25).to_a].flatten.each do |pin|
        define_method("p8_#{pin}") do
          raise StandardError, 'Pin disabled (MMC)'
        end
      end
    end

    module Hdmi
      [28, 29, 31].each do |pin|
        define_method("p9_#{pin}") do
          raise StandardError, 'Pin disabled (HDMI)'
        end
      end
      (27..46).each do |pin|
        define_method("p8_#{pin}") do
          raise StandardError, 'Pin disabled (HDMI)'
        end
      end
    end
  end

  class BeagleBoneBlack < BeagleBone
    {
      'p9_41a' => 'gpio0_20',
      'p9_41b' => 'gpio3_20',
      'p9_42a' => 'gpio0_7',
      'p9_42b' => 'gpio3_18'
    }.each do |name, function|
      define_method(name) do
        send(function)
      end
    end

    def initialize(options = {})
      default_options = {
        capes: %i[emmc hdmi]
      }
      options = default_options.merge(options)

      super()

      extend Cape::Hdmi if options[:capes].include? :hdmi
      extend Cape::Emmc if options[:capes].include? :emmc
    end

    def p9_41
      return @p9_41 if instance_variable_defined?(:@p9_41)
      p9_41a.direction = :in
      @p9_41 = p9_41b # rubocop:disable Naming/VariableNumber
    end

    def p9_42
      return @p9_42 if instance_variable_defined?(:@p9_42)
      p9_42a.direction = :in
      @p9_42 = p9_42b # rubocop:disable Naming/VariableNumber
    end
  end
end
