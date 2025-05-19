set_property SRC_FILE_INFO {cfile:C:/Users/aamalik3/Desktop/ICAP_Readback/ONRHandover/BaseProject/BaseProject.srcs/constrs_1/new/pins.xdc rfile:../../../BaseProject.srcs/constrs_1/new/pins.xdc id:1} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Users/aamalik3/Desktop/ICAP_Readback/ONRHandover/BaseProject/BaseProject.srcs/constrs_1/new/partitions.xdc rfile:../../../BaseProject.srcs/constrs_1/new/partitions.xdc id:2} [current_design]
set_property src_info {type:XDC file:1 line:8 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T22 [get_ports {led[0]}];  # "LD0"
set_property src_info {type:XDC file:1 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T21 [get_ports {led[1]}];  # "LD1"
set_property src_info {type:XDC file:1 line:10 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U22 [get_ports {led[2]}];  # "LD2"
set_property src_info {type:XDC file:1 line:11 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U21 [get_ports {led[3]}];  # "LD3"
set_property src_info {type:XDC file:1 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V22 [get_ports {led[4]}];  # "LD4"
set_property src_info {type:XDC file:1 line:13 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN W22 [get_ports {led[5]}];  # "LD5"
set_property src_info {type:XDC file:1 line:14 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U19 [get_ports {led[6]}];  # "LD6"
set_property src_info {type:XDC file:1 line:15 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U14 [get_ports {led[7]}];  # "LD7"
set_property src_info {type:XDC file:1 line:17 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F22 [get_ports enb]
set_property src_info {type:XDC file:1 line:18 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M15 [get_ports rst]
set_property src_info {type:XDC file:1 line:21 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property src_info {type:XDC file:1 line:22 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];
set_property src_info {type:XDC file:1 line:23 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];
set_property src_info {type:XDC file:1 line:24 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
set_property src_info {type:XDC file:2 line:3 export:INPUT save:INPUT read:READ} [current_design]
create_pblock pblock_custom_ip
resize_pblock [get_pblocks pblock_custom_ip] -add {SLICE_X6Y0:SLICE_X61Y49}
resize_pblock [get_pblocks pblock_custom_ip] -add {DSP48_X0Y0:DSP48_X2Y19}
resize_pblock [get_pblocks pblock_custom_ip] -add {RAMB18_X0Y0:RAMB18_X3Y19}
resize_pblock [get_pblocks pblock_custom_ip] -add {RAMB36_X0Y0:RAMB36_X3Y9}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_custom_ip]
set_property src_info {type:XDC file:2 line:4 export:INPUT save:INPUT read:READ} [current_design]
add_cells_to_pblock [get_pblocks pblock_custom_ip] [get_cells -quiet [list design_1_i/CUSTOM_IP/inst]]
set_property src_info {type:XDC file:2 line:13 export:INPUT save:INPUT read:READ} [current_design]
set_property DONT_TOUCH true [get_cells design_1_i/CUSTOM_IP/inst]
set_property src_info {type:XDC file:2 line:14 export:INPUT save:INPUT read:READ} [current_design]
set_property HD.RECONFIGURABLE true [get_cells design_1_i/CUSTOM_IP/inst]
