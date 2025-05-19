// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Thu Oct 19 13:06:59 2023
// Host        : sophitia running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/aamalik3/Desktop/ICAP_Readback/BaseProject/BaseProject.srcs/sources_1/bd/design_1/ip/design_1_CLK_Gate_0_0/design_1_CLK_Gate_0_0_sim_netlist.v
// Design      : design_1_CLK_Gate_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_CLK_Gate_0_0,CLK_Gate,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "CLK_Gate,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module design_1_CLK_Gate_0_0
   (clk_o,
    clk_i,
    enb);
  output clk_o;
  input clk_i;
  input enb;

  wire clk_i;
  wire clk_o;
  wire enb;

  design_1_CLK_Gate_0_0_CLK_Gate inst
       (.clk_i(clk_i),
        .clk_o(clk_o),
        .enb(enb));
endmodule

(* ORIG_REF_NAME = "CLK_Gate" *) 
module design_1_CLK_Gate_0_0_CLK_Gate
   (clk_o,
    enb,
    clk_i);
  output clk_o;
  input enb;
  input clk_i;

  wire clk_i;
  wire clk_o;
  wire enb;
  wire enb_latch;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h8)) 
    clk_o_INST_0
       (.I0(clk_i),
        .I1(enb_latch),
        .O(clk_o));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0),
    .IS_G_INVERTED(1'b1)) 
    enb_latch_reg
       (.CLR(1'b0),
        .D(enb),
        .G(clk_i),
        .GE(1'b1),
        .Q(enb_latch));
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
