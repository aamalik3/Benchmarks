// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Thu Oct 26 15:14:42 2023
// Host        : sophitia running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/RISC_BENCHMARKS_BASE_PROJ/RISC_BENCHMARKS_BASE_PROJ.srcs/sources_1/bd/design_1/ip/design_1_RISC_BENCHMARK_IP_0_0/design_1_RISC_BENCHMARK_IP_0_0_stub.v
// Design      : design_1_RISC_BENCHMARK_IP_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "RISC_BENCHMARK_IP,Vivado 2018.2" *)
module design_1_RISC_BENCHMARK_IP_0_0(clk, cpu_rst, cpu_start, result_vld, MSB_Bits)
/* synthesis syn_black_box black_box_pad_pin="clk,cpu_rst,cpu_start,result_vld,MSB_Bits[31:0]" */;
  input clk;
  input cpu_rst;
  input cpu_start;
  output result_vld;
  output [31:0]MSB_Bits;
endmodule
