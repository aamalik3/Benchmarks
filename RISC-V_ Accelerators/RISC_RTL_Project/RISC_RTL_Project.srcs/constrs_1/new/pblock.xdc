#create_pblock pblock_risc
#add_cells_to_pblock [get_pblocks pblock_risc] -top
#resize_pblock [get_pblocks pblock_risc] -add {SLICE_X6Y0:SLICE_X61Y49}
#resize_pblock [get_pblocks pblock_risc] -add {DSP48_X0Y0:DSP48_X2Y19}
#resize_pblock [get_pblocks pblock_risc] -add {RAMB18_X0Y0:RAMB18_X3Y19}
#resize_pblock [get_pblocks pblock_risc] -add {RAMB36_X0Y0:RAMB36_X3Y9}

#resize_pblock [get_pblocks pblock_risc] -add {CLOCKREGION_X0Y0:CLOCKREGION_X1Y0}


#create_pblock pblock_risc_v
#resize_pblock pblock_risc_v -add {SLICE_X0Y0:SLICE_X89Y49 DSP48_X0Y0:DSP48_X2Y19 RAMB18_X0Y0:RAMB18_X3Y19 RAMB36_X0Y0:RAMB36_X3Y9}
#endgroup
#add_cells_to_pblock pblock_risc_v [get_cells [list design_1_i/RISC_AES]] -clear_locs

#add_cells_to_pblock [get_pblocks pblock_risc] -top
#resize_pblock [get_pblocks pblock_risc] -add {SLICE_X50Y0:SLICE_X55Y49 SLICE_X0Y1:SLICE_X49Y49}
#resize_pblock [get_pblocks pblock_risc] -add {BUFHCE_X0Y0:BUFHCE_X1Y11}
#resize_pblock [get_pblocks pblock_risc] -add {BUFIO_X0Y0:BUFIO_X0Y3}
#resize_pblock [get_pblocks pblock_risc] -add {BUFMRCE_X0Y0:BUFMRCE_X0Y1}
#resize_pblock [get_pblocks pblock_risc] -add {BUFR_X0Y0:BUFR_X0Y3}
#resize_pblock [get_pblocks pblock_risc] -add {DSP48_X0Y2:DSP48_X2Y19}
#resize_pblock [get_pblocks pblock_risc] -add {IDELAY_X0Y5:IDELAY_X0Y46}
#resize_pblock [get_pblocks pblock_risc] -add {IDELAYCTRL_X0Y0:IDELAYCTRL_X0Y0}
#resize_pblock [get_pblocks pblock_risc] -add {ILOGIC_X0Y5:ILOGIC_X0Y46}
#resize_pblock [get_pblocks pblock_risc] -add {IN_FIFO_X0Y1:IN_FIFO_X0Y2}
#resize_pblock [get_pblocks pblock_risc] -add {IOB_X0Y5:IOB_X0Y46}
#resize_pblock [get_pblocks pblock_risc] -add {OLOGIC_X0Y5:OLOGIC_X0Y46}
#resize_pblock [get_pblocks pblock_risc] -add {OUT_FIFO_X0Y1:OUT_FIFO_X0Y2}
#resize_pblock [get_pblocks pblock_risc] -add {PHASER_IN_PHY_X0Y0:PHASER_IN_PHY_X0Y3}
#resize_pblock [get_pblocks pblock_risc] -add {PHASER_OUT_PHY_X0Y0:PHASER_OUT_PHY_X0Y3}
#resize_pblock [get_pblocks pblock_risc] -add {PHASER_REF_X0Y0:PHASER_REF_X0Y0}
#resize_pblock [get_pblocks pblock_risc] -add {PHY_CONTROL_X0Y0:PHY_CONTROL_X0Y0}
#resize_pblock [get_pblocks pblock_risc] -add {PMV_X0Y1:PMV_X0Y1}
#resize_pblock [get_pblocks pblock_risc] -add {PMVBRAM_X0Y0:PMVBRAM_X3Y0}
#resize_pblock [get_pblocks pblock_risc] -add {PMVIOB_X0Y0:PMVIOB_X0Y0}
#resize_pblock [get_pblocks pblock_risc] -add {RAMB18_X3Y0:RAMB18_X3Y19 RAMB18_X0Y2:RAMB18_X2Y19}
#resize_pblock [get_pblocks pblock_risc] -add {RAMB36_X3Y0:RAMB36_X3Y9 RAMB36_X0Y1:RAMB36_X2Y9}




#resize_pblock [get_pblocks pblock_risc] -add {CLOCKREGION_X1Y1:CLOCKREGION_X1Y1}
#set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets clk_wiz_0/inst/clk_in1_clk_wiz_0]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_wiz_0/inst/clk_in1_clk_wiz_0]


#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets clk_IBUF]

#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets clk_ila]





#create_pblock pblock_risc
#add_cells_to_pblock [get_pblocks pblock_risc] -top
#resize_pblock [get_pblocks pblock_risc] -add {SLICE_X50Y0:SLICE_X55Y49 SLICE_X0Y1:SLICE_X49Y49}
#resize_pblock [get_pblocks pblock_risc] -add {BUFHCE_X0Y0:BUFHCE_X1Y11}
#resize_pblock [get_pblocks pblock_risc] -add {BUFIO_X0Y0:BUFIO_X0Y3}
#resize_pblock [get_pblocks pblock_risc] -add {BUFMRCE_X0Y0:BUFMRCE_X0Y1}
#resize_pblock [get_pblocks pblock_risc] -add {BUFR_X0Y0:BUFR_X0Y3}
#resize_pblock [get_pblocks pblock_risc] -add {DSP48_X0Y2:DSP48_X2Y19}
#resize_pblock [get_pblocks pblock_risc] -add {IDELAY_X0Y5:IDELAY_X0Y46}
#resize_pblock [get_pblocks pblock_risc] -add {IDELAYCTRL_X0Y0:IDELAYCTRL_X0Y0}
#resize_pblock [get_pblocks pblock_risc] -add {ILOGIC_X0Y5:ILOGIC_X0Y46}
#resize_pblock [get_pblocks pblock_risc] -add {IN_FIFO_X0Y1:IN_FIFO_X0Y2}
#resize_pblock [get_pblocks pblock_risc] -add {IOB_X0Y5:IOB_X0Y46}
#resize_pblock [get_pblocks pblock_risc] -add {OLOGIC_X0Y5:OLOGIC_X0Y46}
#resize_pblock [get_pblocks pblock_risc] -add {OUT_FIFO_X0Y1:OUT_FIFO_X0Y2}
#resize_pblock [get_pblocks pblock_risc] -add {PHASER_IN_PHY_X0Y0:PHASER_IN_PHY_X0Y3}
#resize_pblock [get_pblocks pblock_risc] -add {PHASER_OUT_PHY_X0Y0:PHASER_OUT_PHY_X0Y3}
#resize_pblock [get_pblocks pblock_risc] -add {PHASER_REF_X0Y0:PHASER_REF_X0Y0}
#resize_pblock [get_pblocks pblock_risc] -add {PHY_CONTROL_X0Y0:PHY_CONTROL_X0Y0}
#resize_pblock [get_pblocks pblock_risc] -add {PMV_X0Y1:PMV_X0Y1}
#resize_pblock [get_pblocks pblock_risc] -add {PMVBRAM_X0Y0:PMVBRAM_X3Y0}
#resize_pblock [get_pblocks pblock_risc] -add {PMVIOB_X0Y0:PMVIOB_X0Y0}
#resize_pblock [get_pblocks pblock_risc] -add {RAMB18_X3Y0:RAMB18_X3Y19 RAMB18_X0Y2:RAMB18_X2Y19}
#resize_pblock [get_pblocks pblock_risc] -add {RAMB36_X3Y0:RAMB36_X3Y9 RAMB36_X0Y1:RAMB36_X2Y9}



