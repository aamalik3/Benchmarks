
// Copyright 2018 Robert Balas <balasr@student.ethz.ch>
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Wrapper for a CV32E40X testbench, containing CV32E40X, Memory and stdout peripheral
// Contributor: Robert Balas <balasr@student.ethz.ch>
// Module renamed from riscv_wrapper to cv32e40x_tb_wrapper because (1) the
// name of the core changed, and (2) the design has a cv32e40x_wrapper module.
//
// SPDX-License-Identifier: Apache-2.0 WITH SHL-0.51

module cv32e40x_tb_wrapper
    #(parameter // Parameters used by TB
                INSTR_RDATA_WIDTH = 32,
                RAM_ADDR_WIDTH    = 22,
                BOOT_ADDR         = 'h80,
                DM_HALTADDRESS    = 32'h1A11_0800,
                HART_ID           = 32'h0000_0000,
                IMP_PATCH_ID      = 4'h0,
                // Parameters used by DUT
                NUM_MHPMCOUNTERS  = 1
    )
    (input logic         clk_i,
     input logic         rst_ni,

     input logic         fetch_enable_i,
     
     input logic         cpu_cont_en, //added
     output logic        trigger_o, //added
     output logic        cpu_stalled, //added
     output logic        tests_passed_o,
     output logic        tests_failed_o,
     output logic [31:0] exit_value_o,
     output logic        exit_valid_o);

    // signals connecting core to memory
    logic                         instr_req;
    logic                         instr_gnt;
    logic                         instr_rvalid;
    logic [31:0]                  instr_addr;
    logic [INSTR_RDATA_WIDTH-1:0] instr_rdata;

    logic                         data_req;
    logic                         data_gnt;
    logic                         data_rvalid;
    logic [31:0]                  data_addr;
    logic                         data_we;
    logic [3:0]                   data_be;
    logic [31:0]                  data_rdata;
    logic [31:0]                  data_wdata;

    // signals to debug unit
    logic                         debug_req;

    // irq signals (not used)
    logic [0:31]                  irq;
    logic [0:4]                   irq_id_in;
    logic                         irq_ack;
    logic [0:4]                   irq_id_out;
    logic                         irq_sec;

    logic [31:0]                  pc_o;         //program counter - added
    logic                         clk_new;      //added
    logic                         clk_en;       //added
    logic                         trigger_flag; //added
    logic [17:0]		   counter;       //added
    logic                         cpu_start;	
 
    // interrupts (only timer for now)
    assign irq_sec     = '0;
	
    //trigger output - added
    //assign trigger_o = (pc_o == 32'h00000102 && ~trigger_flag); //osc will start to capture data
    
    //added
    reg result_vld;
    reg [127:0] result;
    always @(posedge clk_i, negedge rst_ni) begin
	if (~rst_ni) begin
		clk_en  	 	<= '1;
		cpu_stalled 		<= '0;
		trigger_o              <= '0;
		counter                <= '0;
		result_vld             <= '0;
		result                 <= '0;
		cpu_start              <= '0;
	end else begin
		counter                <= counter + 1;
		if(counter == 1)
			cpu_start <= 1;
		if(counter == 19'h205 && result_vld ==0) begin
			result[31:0]   <= pc_o;
		end else if(counter == 19'h213 && result_vld ==0) begin
			result[63:32]   <= pc_o;
		end else if(counter == 19'h215 && result_vld ==0) begin
			result[95:64]   <= pc_o;
		end else if(counter == 19'h223 && result_vld ==0) begin
			result[127:96]   <= pc_o;
			result_vld       <= 1;
		end
		
		if(pc_o == 32'h00000102) begin
			trigger_o      <= '1;
		end
		if(pc_o == 32'h00000144) begin
			//clk_en  	<= '0;
			trigger_o      <= '0;
			//cpu_stalled 	<= '1;
		end	
		if(cpu_cont_en) begin
			clk_en 	<= '1;
			cpu_stalled 	<= '0;
			//trigger_flag <= '0;
		end	
	end
    end
    
    assign clk_new =  clk_i & clk_en ;

    // eXtension Interface
    if_xif #(
        .X_NUM_RS    ( 2  ),
        .X_MEM_WIDTH ( 32 ),
        .X_RFR_WIDTH ( 32 ),
        .X_RFW_WIDTH ( 32 ),
        .X_MISA      ( '0 )
    ) ext_if();


    // instantiate the core
    cv32e40x_core #(
                .NUM_MHPMCOUNTERS (NUM_MHPMCOUNTERS)
                )
    cv32e40x_core_i
        (
        // Clock and Reset
        .clk_i                  ( clk_i               ), //clk_i                 ),
        .rst_ni                 ( rst_ni                ),
	
        .scan_cg_en_i           ( 1'b0                  ),

        // Static configuration
        .boot_addr_i            ( BOOT_ADDR             ),
        .dm_exception_addr_i    ( '0                    ),
        .dm_halt_addr_i         ( DM_HALTADDRESS        ),
        .mhartid_i              ( HART_ID               ),
        .mimpid_patch_i         ( IMP_PATCH_ID          ),
        .mtvec_addr_i           ( '0                    ), 
        
        // Instruction memory interface
        .instr_req_o            ( instr_req             ),
        .instr_gnt_i            ( instr_gnt             ),
        .instr_rvalid_i         ( instr_rvalid          ),
        .instr_addr_o           ( instr_addr            ),
        .instr_memtype_o        (                       ),
        .instr_prot_o           (                       ),
        .instr_dbg_o            (                       ),
        .instr_rdata_i          ( instr_rdata           ),
        .instr_err_i            ( 1'b0                  ),

        // Data memory interface
        .data_req_o             ( data_req              ),
        .data_gnt_i             ( data_gnt              ),
        .data_rvalid_i          ( data_rvalid           ),
        .data_addr_o            ( data_addr             ),
        .data_be_o              ( data_be               ),
        .data_we_o              ( data_we               ),
        .data_wdata_o           ( data_wdata            ),
        .data_memtype_o         (                       ), 
        .data_prot_o            (                       ),
        .data_dbg_o             (                       ),
        .data_err_i             ( 1'b0                  ),
        .data_atop_o            (                       ),
        .data_rdata_i           ( data_rdata            ),
        .data_exokay_i          ( 1'b1                  ),

        // Cycle Count
        .mcycle_o               (                       ),

        // Time input
        .time_i                 ( '0                   ),

        // eXtension interface
        .xif_compressed_if      ( ext_if                ),
        .xif_issue_if           ( ext_if                ),
        .xif_commit_if          ( ext_if                ),
        .xif_mem_if             ( ext_if                ),
        .xif_mem_result_if      ( ext_if                ),
        .xif_result_if          ( ext_if                ),

        // Basic interrupt architecture
        .irq_i                  ( {32{1'b0}}            ),

        // Event wakeup signals
        .wu_wfe_i               ( 1'b0                  ),
        .wu_wrs_i               ( 1'b0                  ),

        .clic_irq_i             (  '0                   ),
        .clic_irq_id_i          (  '0                   ),
        .clic_irq_level_i       (  '0                   ),
        .clic_irq_priv_i        (  '0                   ),
        .clic_irq_shv_i         (  '0                   ),
        
        // Fencei flush handshake
        .fencei_flush_req_o     (                       ),
        .fencei_flush_ack_i     ( 1'b0                  ),

        // Debug interface
        .debug_req_i            ( 1'b0                  ),
        .debug_havereset_o      (                       ),
        .debug_running_o        (                       ),
        .debug_halted_o         (                       ),
        .debug_pc_valid_o       (                       ),
        .debug_pc_o             (                       ),

        // CPU Control Signals
        .fetch_enable_i         ( cpu_start        ),
        .core_sleep_o           (                       ),
        .pc_o                   ( pc_o                  )   //added
      );

    // this handles read to RAM and memory mapped pseudo peripherals
    //mm_ram
    //    #(.RAM_ADDR_WIDTH (RAM_ADDR_WIDTH),
    //      .INSTR_RDATA_WIDTH (INSTR_RDATA_WIDTH))
    //ram_i
    //    (.clk_i          ( clk_i                                     ),
    //     .rst_ni         ( rst_ni                                    ),
    //     .dm_halt_addr_i ( DM_HALTADDRESS                            ),
	//
    //     .instr_req_i    ( instr_req                                 ),
    //     .instr_addr_i   ( { {10{1'b0}},
    //                         instr_addr[RAM_ADDR_WIDTH-1:0]
    //                       }                                         ),
    //     .instr_rdata_o  ( instr_rdata                               ),
    //     .instr_rvalid_o ( instr_rvalid                              ),
    //     .instr_gnt_o    ( instr_gnt                                 ),
	//
    //     .data_req_i     ( data_req                                  ),
    //     .data_addr_i    ( data_addr                                 ),
    //     .data_we_i      ( data_we                                   ),
    //     .data_be_i      ( data_be                                   ),
    //     .data_wdata_i   ( data_wdata                                ),
    //     .data_rdata_o   ( data_rdata                                ),
    //     .data_rvalid_o  ( data_rvalid                               ),
    //     .data_gnt_o     ( data_gnt                                  ),
	//
    //     .irq_id_i       ( irq_id_out                                ),
    //     .irq_ack_i      ( irq_ack                                   ),
    //     .irq_o          ( irq                                       ),
	//
    //     .debug_req_o    ( debug_req                                 ),
	//
    //     .pc_core_id_i   ( cv32e40x_core_i.if_id_pipe.pc             ),
	//
    //     .tests_passed_o ( tests_passed_o                            ),
    //     .tests_failed_o ( tests_failed_o                            ),
    //     .exit_valid_o   ( exit_valid_o                              ),
    //     .exit_value_o   ( exit_value_o                              ));
		 
		 localparam DBG_ADDR_WIDTH    =  14;
		 
		 wire logic [31:0]              dm_halt_addr_i;
		 wire [31:0]                    instr_addr_i;
		 wire  [RAM_ADDR_WIDTH-1:0]     instr_addr_remap;
		 logic [RAM_ADDR_WIDTH-1:0]     data_addr_dec;
		 wire [31:0]                    data_addr_i;
		 
		 assign dm_halt_addr_i  = DM_HALTADDRESS;
		 assign instr_addr_i	= { {10{1'b0}}, instr_addr[RAM_ADDR_WIDTH-1:0]};
		 assign data_addr_i		= data_addr;
		 
		 
		 assign instr_addr_remap =  ( (instr_addr_i >= dm_halt_addr_i) &&
                                   (instr_addr_i < (dm_halt_addr_i + (2 ** DBG_ADDR_WIDTH)) ) ) ?
                                   (instr_addr_i - dm_halt_addr_i) +  2**RAM_ADDR_WIDTH - 2**DBG_ADDR_WIDTH :
                                   instr_addr_i ;
								   
								   
								   
		always_comb begin
			if ( (data_addr_i >= dm_halt_addr_i) &&
                    		(data_addr_i < (dm_halt_addr_i + (2 ** DBG_ADDR_WIDTH))
				))
                 		data_addr_dec  = (data_addr_i[RAM_ADDR_WIDTH-1:0] - dm_halt_addr_i[RAM_ADDR_WIDTH-1:0]) +
                               2**RAM_ADDR_WIDTH - 2**DBG_ADDR_WIDTH;
           		 else
				data_addr_dec  = data_addr_i[RAM_ADDR_WIDTH-1:0];
		
		end
		 
		 always @(posedge clk_new, negedge rst_ni) begin 
			if (~rst_ni) begin
				instr_rvalid   <= '0;
				data_rvalid    <= '0;
			end else begin
				instr_rvalid   <= instr_req;
				data_rvalid    <= data_req;
			end
		 end
		 
		 assign instr_gnt = instr_req;
		 assign data_gnt = data_req;
		 
	// instantiate the ram
    dp_ram
        #(.ADDR_WIDTH (RAM_ADDR_WIDTH),
          .INSTR_RDATA_WIDTH(INSTR_RDATA_WIDTH))
    dp_ram_i
        (
         .clk_i     ( clk_i            ), //clk_i                 ),
         .rst_ni    ( rst_ni           ),
         .en_a_i    ( instr_req        ),
         .addr_a_i  ( instr_addr_remap ),
         .wdata_a_i ( '0               ),	// Not writing so ignored
         .rdata_a_o ( instr_rdata      ),
         .we_a_i    ( '0               ),
         .be_a_i    ( 4'b0000          ),	// Always want 32-bits

         .en_b_i    ( data_req    	),
         .addr_b_i  ( data_addr_dec    ),
         .wdata_b_i ( data_wdata  	),
         .rdata_b_o ( data_rdata 	),
         .we_b_i    ( data_we     	),
         .be_b_i    ( data_be     	));
		 

endmodule // cv32e40x_tb_wrapper
