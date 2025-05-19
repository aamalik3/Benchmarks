// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Thu Oct 19 13:06:59 2023
// Host        : sophitia running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/aamalik3/Desktop/ICAP_Readback/BaseProject/BaseProject.srcs/sources_1/bd/design_1/ip/design_1_STARTUP_0_0/design_1_STARTUP_0_0_stub.v
// Design      : design_1_STARTUP_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "STARTUP,Vivado 2018.2" *)
module design_1_STARTUP_0_0(GSR_i, EOS_O)
/* synthesis syn_black_box black_box_pad_pin="GSR_i,EOS_O" */;
  input GSR_i;
  output EOS_O;
endmodule
