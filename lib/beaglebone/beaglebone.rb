require 'beaglebone/am335x'

class BeagleBone < AM335x
  {
    # P8
    'p8_07' => 'gpio2_02',
    'p8_08' => 'gpio2_03',
    'p8_09' => 'gpio2_05',
    'p8_10' => 'gpio2_04',
    'p8_11' => 'gpio1_13',
    'p8_12' => 'gpio1_12',
    'p8_13' => 'gpio0_23',
    'p8_14' => 'gpio0_26',
    'p8_15' => 'gpio1_15',
    'p8_16' => 'gpio1_14',
    'p8_17' => 'gpio0_27',
    'p8_18' => 'gpio2_01',
    'p8_19' => 'gpio0_22',
    'p8_26' => 'gpio1_29',
    'p8_27' => 'gpio2_22',
    'p8_28' => 'gpio2_24',
    'p8_29' => 'gpio2_23',
    'p8_30' => 'gpio2_25',
    'p8_31' => 'gpio0_10',
    'p8_32' => 'gpio0_11',
    'p8_33' => 'gpio0_09',
    'p8_35' => 'gpio0_08',
    'p8_37' => 'gpio2_14',
    'p8_39' => 'gpio2_12',
    'p8_40' => 'gpio2_13',
    'p8_41' => 'gpio2_10',
    'p8_42' => 'gpio2_11',
    'p8_43' => 'gpio2_08',
    'p8_44' => 'gpio2_09',
    'p8_46' => 'gpio2_07',

    # P9
    'p9_11' => 'gpio0_30',
    'p9_12' => 'gpio1_28',
    'p9_13' => 'gpio0_31',
    'p9_14' => 'gpio1_18',
    'p9_15' => 'gpio1_16',
    'p9_16' => 'gpio1_19',
    'p9_17' => 'gpio0_05',
    'p9_18' => 'gpio0_04',
    'p9_19' => 'gpio0_13',
    'p9_20' => 'gpio0_12',
    'p9_21' => 'gpio0_03',
    'p9_22' => 'gpio0_02',
    'p9_23' => 'gpio1_17',
    'p9_24' => 'gpio0_15',
    'p9_25' => 'gpio3_21',
    'p9_26' => 'gpio0_14',
    'p9_27' => 'gpio3_19',
    'p9_28' => 'gpio3_17',
    'p9_29' => 'gpio3_15',
    'p9_30' => 'gpio3_16',
    'p9_31' => 'gpio3_14',
    'p9_33' => 'ain4',
    'p9_35' => 'ain6',
    'p9_36' => 'ain5',
    'p9_37' => 'ain2',
    'p9_38' => 'ain3',
    'p9_39' => 'ain0',
    'p9_40' => 'ain1',

    'usr0' => 'gpio1_21',
    'usr1' => 'gpio1_22',
    'usr2' => 'gpio1_23',
    'usr3' => 'gpio1_24'
  }.each do |name, function|
    define_method(name) do
      send(function)
    end
  end
end
