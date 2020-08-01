## Clock signal 100 MHz
set_property -dict { PACKAGE_PIN H4  IOSTANDARD LVCMOS33 } [get_ports { clk_100MHz }]; #IO_L13P_T2_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk_100MHz }];
#UART0
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports UART0_Rx];
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports UART0_Tx];
#key
set_property -dict {PACKAGE_PIN C3 IOSTANDARD LVCMOS33} [get_ports rst]
set_property -dict { PACKAGE_PIN M4  IOSTANDARD LVCMOS33 } [get_ports Key];
set_property -dict { PACKAGE_PIN A2  IOSTANDARD LVCMOS33 } [get_ports int1];
set_property -dict { PACKAGE_PIN B2  IOSTANDARD LVCMOS33 } [get_ports int2];
#IO
set_property PACKAGE_PIN A4 [get_ports EncoderA_i]
set_property IOSTANDARD LVCMOS33 [get_ports EncoderA_i]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets EncoderA_i_IBUF]
set_property PACKAGE_PIN B5 [get_ports EncoderB_i]
set_property IOSTANDARD LVCMOS33 [get_ports EncoderB_i]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets EncoderB_i_IBUF]