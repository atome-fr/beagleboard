require 'beagleboard/am335x'

RSpec.describe AM335x do
  it { should respond_to(:ain0) }
  it { should respond_to(:ain1) }
  it { should respond_to(:ain2) }
  it { should respond_to(:ain3) }
  it { should respond_to(:ain4) }
  it { should respond_to(:ain5) }
  it { should respond_to(:ain6) }
  it { should_not respond_to(:ain7) }

  it { should respond_to(:gpio0_12) }
  it { should respond_to(:gpio1_12) }
  it { should respond_to(:gpio2_12) }
  it { should respond_to(:gpio3_12) }

  it { should_not respond_to(:gpio4_12) }
  it { should_not respond_to(:gpio2_32) }
  it { should_not respond_to(:gpio2_01) }
end
