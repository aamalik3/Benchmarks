###############################################################################################
#startgroup
#create_pblock pblock_risc
#add_cells_to_pblock [get_pblocks pblock_risc] [get_cells -quiet [list design_1_i/RISC_BENCHMARK_IP/inst]]
#resize_pblock pblock_risc -add {SLICE_X0Y0:SLICE_X89Y49 DSP48_X0Y0:DSP48_X2Y19 RAMB18_X0Y0:RAMB18_X3Y19 RAMB36_X0Y0:RAMB36_X3Y9}
#endgroup

startgroup
create_pblock pblock_risc
add_cells_to_pblock [get_pblocks pblock_risc] [get_cells -quiet [list design_1_i/RISC_BENCHMARK_IP/inst]]
resize_pblock [get_pblocks pblock_risc] -add {SLICE_X6Y0:SLICE_X61Y49}
resize_pblock [get_pblocks pblock_risc] -add {DSP48_X0Y0:DSP48_X2Y19}
resize_pblock [get_pblocks pblock_risc] -add {RAMB18_X0Y0:RAMB18_X3Y19}
resize_pblock [get_pblocks pblock_risc] -add {RAMB36_X0Y0:RAMB36_X3Y9}
endgroup

################################################################################################
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_risc]
set_property SNAPPING_MODE ROUTING [get_pblocks pblock_risc]
set_property DONT_TOUCH true [get_cells design_1_i/RISC_BENCHMARK_IP/inst]
set_property HD.RECONFIGURABLE true [get_cells design_1_i/RISC_BENCHMARK_IP/inst]
################################################################################################
