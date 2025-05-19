set_property SEVERITY {Warning} [get_drc_checks NSTD-1];
set_property SEVERITY {Warning} [get_drc_checks UCIO-1];

#set_property BITSTREAM.GENERAL.PERFRAMECRC YES [current_design]

set_property PACKAGE_PIN Y9 [get_ports clk]
#set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN M15 [get_ports cpu_rst]
#set_property IOSTANDARD LVCMOS33 [get_ports cpu_rst]
create_clock -period 10  -name clk   [get_ports clk]
set_max_delay -datapath_only -from [all_inputs] -to [all_outputs] 10.00
set_property PACKAGE_PIN F22 [get_ports cpu_start]
#set_property IOSTANDARD LVCMOS33 [get_ports cpu_start]

#set_property PACKAGE_PIN R16 [get_ports trig_in]
#set_property IOSTANDARD LVCMOS33 [get_ports trig_in]

#set_property PACKAGE_PIN T22 [get_ports cpu_stalled]
#set_property IOSTANDARD LVCMOS33 [get_ports cpu_stalled]

#set_property PACKAGE_PIN U22 [get_ports pass]
#set_property IOSTANDARD LVCMOS33 [get_ports pass]

set_property PACKAGE_PIN T21 [get_ports result_vld]
#set_property IOSTANDARD LVCMOS33 [get_ports result_vld]




set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];

# Set the bank voltage for IO Bank 34 to 1.8V by default.
# set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];
# set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];

# Set the bank voltage for IO Bank 35 to 1.8V by default.
# set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];
# set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 35]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];

# Note that the bank voltage for IO Bank 13 is fixed to 3.3V on ZedBoard. 
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];