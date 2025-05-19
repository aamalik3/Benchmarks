set_property SRC_FILE_INFO {cfile:C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/RISC_BENCHMARKS_BASE_PROJ/RISC_BENCHMARKS_BASE_PROJ.srcs/constrs_1/new/pins.xdc rfile:../../../RISC_BENCHMARKS_BASE_PROJ.srcs/constrs_1/new/pins.xdc id:1} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/RISC_BENCHMARKS_BASE_PROJ/RISC_BENCHMARKS_BASE_PROJ.srcs/constrs_1/new/partitions.xdc rfile:../../../RISC_BENCHMARKS_BASE_PROJ.srcs/constrs_1/new/partitions.xdc id:2} [current_design]
set_property src_info {type:XDC file:1 line:11 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U22 [get_ports {led[0]}];
set_property src_info {type:XDC file:1 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U19 [get_ports {GLED[0]}];
set_property src_info {type:XDC file:1 line:13 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F22 [get_ports enb];
set_property src_info {type:XDC file:1 line:14 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M15 [get_ports rst];
set_property src_info {type:XDC file:1 line:19 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property src_info {type:XDC file:1 line:20 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];
set_property src_info {type:XDC file:1 line:21 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];
set_property src_info {type:XDC file:2 line:9 export:INPUT save:INPUT read:READ} [current_design]
create_pblock pblock_risc
resize_pblock [get_pblocks pblock_risc] -add {SLICE_X6Y0:SLICE_X61Y49}
resize_pblock [get_pblocks pblock_risc] -add {DSP48_X0Y0:DSP48_X2Y19}
resize_pblock [get_pblocks pblock_risc] -add {RAMB18_X0Y0:RAMB18_X3Y19}
resize_pblock [get_pblocks pblock_risc] -add {RAMB36_X0Y0:RAMB36_X3Y9}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_risc]
set_property SNAPPING_MODE ROUTING [get_pblocks pblock_risc]
set_property src_info {type:XDC file:2 line:10 export:INPUT save:INPUT read:READ} [current_design]
add_cells_to_pblock [get_pblocks pblock_risc] [get_cells -quiet [list design_1_i/RISC_BENCHMARK_IP/inst]]
set_property src_info {type:XDC file:2 line:20 export:INPUT save:INPUT read:READ} [current_design]
set_property DONT_TOUCH true [get_cells design_1_i/RISC_BENCHMARK_IP/inst]
set_property src_info {type:XDC file:2 line:21 export:INPUT save:INPUT read:READ} [current_design]
set_property HD.RECONFIGURABLE true [get_cells design_1_i/RISC_BENCHMARK_IP/inst]
