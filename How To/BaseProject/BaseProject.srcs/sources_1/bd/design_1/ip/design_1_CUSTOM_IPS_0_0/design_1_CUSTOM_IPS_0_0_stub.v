// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Mon May 27 15:01:08 2024
// Host        : sophitia running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/aamalik3/Desktop/ICAP_Readback/ONRHandover/BaseProject/BaseProject.srcs/sources_1/bd/design_1/ip/design_1_CUSTOM_IPS_0_0/design_1_CUSTOM_IPS_0_0_stub.v
// Design      : design_1_CUSTOM_IPS_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "CUSTOM_IPS,Vivado 2018.2" *)
module design_1_CUSTOM_IPS_0_0(clock, reset, Output_1, Output_Bus)
/* synthesis syn_black_box black_box_pad_pin="clock,reset,Output_1[7:0],Output_Bus[31:0]" */;
  input clock;
  input reset;
  output [7:0]Output_1;
  output [31:0]Output_Bus;
endmodule
