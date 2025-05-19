`timescale 1 ns / 1 ps
 module dp_ram_3
    #(parameter ADDR_WIDTH = 22,
      parameter INSTR_RDATA_WIDTH = 32)
    (input logic                          clk,
     input logic                          mem_valid_a,
     input logic [ADDR_WIDTH-1:0]         mem_addr_a,
     input logic [INSTR_RDATA_WIDTH-1:0]  mem_wdata_a,
     output logic [INSTR_RDATA_WIDTH-1:0] mem_rdata_a,
     input logic                          mem_wen_a,
     input logic                          mem_wstrb_a,

     input logic                          mem_valid_b,
     input logic [ADDR_WIDTH-1:0]         mem_addr_b,
     input logic [INSTR_RDATA_WIDTH-1:0]  mem_wdata_b,
     output logic [INSTR_RDATA_WIDTH-1:0] mem_rdata_b,
     input logic                          mem_wen_b,
     input logic                          mem_wstrb_b
     );

    localparam bytes = 2**ADDR_WIDTH-1;

    (*KEEP = "true" *)  logic [INSTR_RDATA_WIDTH-1:0]    memory[0:bytes];
    (*KEEP = "true" *)  logic [ADDR_WIDTH-1:0]           mem_address_a;
    (*KEEP = "true" *)  logic [ADDR_WIDTH-1:0]           mem_address_b;

   `include "parameters.vh"
    initial begin
        $readmemh(`File3,memory);
        $display ("File Selected : %s",`File3);
    end
    
    always_comb mem_address_a = {mem_addr_a[ADDR_WIDTH-1:2], 2'b0};
    always_comb mem_address_b = {mem_addr_b[ADDR_WIDTH-1:2], 2'b0};
    
    always @(posedge clk) begin
	    if (mem_valid_a) 
		    mem_rdata_a <= memory[mem_address_a >> 2];
    end
 
    	
    always @(posedge clk) begin
        if (mem_valid_b) begin
            if (mem_wen_b) begin
                if (mem_wstrb_b) memory[mem_address_b >>2][7:0] <= mem_wdata_b[7:0];
            end
            else begin
		        mem_rdata_b <= memory[mem_address_b >> 2];
            end
        end
    end
    
endmodule // dp_ram


