require 'beagleboard/beaglebone'

module BeagleBoard
  class BeagleBoneBlack < BeagleBone
    [(3..6).to_a, (20..25).to_a].flatten.each do |pin|
      define_method("p8_#{pin}") do
        raise StandardError, 'Pin disabled (MMC)'
      end
    end
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
