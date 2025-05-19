// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Thu Oct 26 15:14:42 2023
// Host        : sophitia running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/RISC_BENCHMARKS_BASE_PROJ/RISC_BENCHMARKS_BASE_PROJ.srcs/sources_1/bd/design_1/ip/design_1_RISC_BENCHMARK_IP_0_0/design_1_RISC_BENCHMARK_IP_0_0_sim_netlist.v
// Design      : design_1_RISC_BENCHMARK_IP_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_RISC_BENCHMARK_IP_0_0,RISC_BENCHMARK_IP,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "RISC_BENCHMARK_IP,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module design_1_RISC_BENCHMARK_IP_0_0
   (clk,
    cpu_rst,
    cpu_start,
    result_vld,
    MSB_Bits);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK1" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 cpu_rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME cpu_rst, POLARITY ACTIVE_LOW" *) input cpu_rst;
  input cpu_start;
  output result_vld;
  output [31:0]MSB_Bits;

  wire [31:0]MSB_Bits;
  wire clk;
  wire cpu_rst;
  wire cpu_start;
  wire result_vld;

  design_1_RISC_BENCHMARK_IP_0_0_RISC_BENCHMARK_IP inst
       (.MSB_Bits(MSB_Bits),
        .clk(clk),
        .cpu_rst(cpu_rst),
        .cpu_start(cpu_start),
        .result_vld(result_vld));
endmodule

(* ORIG_REF_NAME = "RISC_BENCHMARK_IP" *) 
module design_1_RISC_BENCHMARK_IP_0_0_RISC_BENCHMARK_IP
   (clk,
    cpu_rst,
    cpu_start,
    result_vld,
    MSB_Bits);
  input clk;
  input cpu_rst;
  input cpu_start;
  output result_vld;
  output [31:0]MSB_Bits;


endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
