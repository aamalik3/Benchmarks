set_property BITSTREAM.GENERAL.CRC DISABLE [current_design]

#set_property BITSTREAM.GENERAL.PERFRAMECRC YES [current_design]


#set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {GLED[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports enb]
#set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property PACKAGE_PIN U22 [get_ports {led[0]}];
set_property PACKAGE_PIN U19 [get_ports {GLED[0]}];
set_property PACKAGE_PIN F22 [get_ports enb];
set_property PACKAGE_PIN M15 [get_ports rst];




set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];