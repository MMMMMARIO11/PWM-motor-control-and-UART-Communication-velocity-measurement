## Clock signal 100 MHz

set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports clk_100MHz]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_100MHz}];

set_property -dict { PACKAGE_PIN B1  IOSTANDARD LVCMOS33 } [get_ports {PWM}];
set_property -dict { PACKAGE_PIN A4  IOSTANDARD LVCMOS33 } [get_ports {PWM_1}];
set_property -dict { PACKAGE_PIN A2  IOSTANDARD LVCMOS33 } [get_ports int1];
set_property -dict { PACKAGE_PIN B2  IOSTANDARD LVCMOS33 } [get_ports int2];