###############################################################################################
startgroup
create_pblock pblock_custom_ip
add_cells_to_pblock [get_pblocks pblock_custom_ip] [get_cells -quiet [list design_1_i/CUSTOM_IP/inst]]
resize_pblock [get_pblocks pblock_custom_ip] -add {SLICE_X6Y0:SLICE_X61Y49}
resize_pblock [get_pblocks pblock_custom_ip] -add {DSP48_X0Y0:DSP48_X2Y19}
resize_pblock [get_pblocks pblock_custom_ip] -add {RAMB18_X0Y0:RAMB18_X3Y19}
resize_pblock [get_pblocks pblock_custom_ip] -add {RAMB36_X0Y0:RAMB36_X3Y9}
endgroup

################################################################################################
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_custom_ip]
set_property DONT_TOUCH true [get_cells design_1_i/CUSTOM_IP/inst]
set_property HD.RECONFIGURABLE true [get_cells design_1_i/CUSTOM_IP/inst]
################################################################################################
