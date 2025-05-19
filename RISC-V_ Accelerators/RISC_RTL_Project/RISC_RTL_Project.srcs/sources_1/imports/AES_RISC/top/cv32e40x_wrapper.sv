`timescale 1 ns / 1 ps

module cv32e40x_wrapper
    #(parameter // Parameters used by TB
                INSTR_RDATA_WIDTH = 32,
                RAM_ADDR_WIDTH    = 19,
                BOOT_ADDR         = 'h80,
                DM_HALTADDRESS    = 32'h1A11_0800,
                HART_ID           = 32'h0000_0000,
                IMP_PATCH_ID      = 4'h0,
                // Parameters used by DUT
                NUM_MHPMCOUNTERS  = 1
    )
    (input logic          clk_i,                    (*KEEP = "true" *) 
     input logic          clk_ila,                  (*KEEP = "true" *)                  
     input logic          rst_ni,
     input logic          fetch_enable_i,
     input logic          cpu_start,
     
//     output logic         pass,      
     output logic         trigger_o,   
     output logic [31 :0] result,                   (*KEEP = "true" *) 
     output logic         result_vld    
    );

    // signals connecting core to memory
    logic                         instr_req;
    logic                         instr_gnt;
    logic                         instr_rvalid;
    logic [31:0]                  instr_addr;
    logic [INSTR_RDATA_WIDTH-1:0] instr_rdata;

    logic                         data_req;
    logic                         data_gnt;
    logic                         data_rvalid;
    logic [31:0]                  data_addr;        (*KEEP = "true" *) 
    logic                         data_we;
    logic [3:0]                   data_be;
    logic [31:0]                  data_rdata;       (*KEEP = "true" *) 
    logic [31:0]                  data_wdata;

    // signals to debug unit
    logic                         debug_req;

    // irq signals (not used)
    logic [0:31]                  irq;
    logic [0:4]                   irq_id_in;
    logic                         irq_ack;
    logic [0:4]                   irq_id_out;
    logic                         irq_sec;          (*KEEP = "true" *) 

    logic [31:0]                  pc_o;       
    logic                         clk_new;     
    logic                         clk_en;       
    logic [31:0]                  counter;      
    logic                         rst;


    // interrupts (only timer for now)
    assign irq_sec     = '0;

    localparam DBG_ADDR_WIDTH    =  14;
		 
    wire logic [31:0]              dm_halt_addr_i;
    wire [31:0]                    instr_addr_i;
    wire  [RAM_ADDR_WIDTH-1:0]     instr_addr_remap;
    logic [18:0]     mem_addr_a;
//    wire  [RAM_ADDR_WIDTH-1:0]     mem_overwrite;
    logic [RAM_ADDR_WIDTH-1:0]     data_addr_dec;
    logic          mem_wen_a   ;
    wire [31:0]                    data_addr_i;        
    always @(posedge clk_i, negedge rst_ni) begin
        if (~rst_ni) begin
//            clk_en                <= '1;
            result                <= {1{32'hDEAD_BEEF}};
            trigger_o             <= '0;
            counter               <= '0;
            result_vld            <= '0;
        end
        else if(cpu_start) 
               begin         
                    counter              <= counter + 1;
                    result     <= data_wdata;  
       //                 if(pc_o == 32'h13A && data_we   && data_addr_i == 32'h003FFFD0) begin                                
                        // if(pc_o == 32'h134 && data_we   && data_addr_i == 32'h003FFFD0) begin                                
                        if(pc_o == 32'h552 && data_we   && data_addr_i == 32'h003F_BB2C) begin                                                           
                        trigger_o        <= 1'b1;
//                        result     <= data_wdata;  
//                        result  <= {8{4'h1}};  
                        result_vld       <= 1'b1;
                   end
       //            else if(pc_o == 32'h158 && data_we   && data_addr_i == 32'h003FFFD4) begin                                
                   // else if(pc_o == 32'h152 && data_we   && data_addr_i == 32'h003FFFD4) begin                                
                   else if(pc_o == 32'h23E && data_we   && data_addr_i == 32'h003FFFB8) begin                                
                          
                        trigger_o        <= 1'b1;
//                        result         <= data_wdata; 
//                        result  <= {8{4'h2}};    
                        result_vld       <= 1'b1;
                   end
       //            else if(pc_o == 32'h176 && data_we   && data_addr_i == 32'h003FFFD8) begin                                
                   // else if(pc_o == 32'h170 && data_we   && data_addr_i == 32'h003FFFD8) begin                                
                   else if(pc_o == 32'h252 && data_we   && data_addr_i == 32'h003FFFBC) begin                                
                         trigger_o       <= 1'b1;
//                         result       <= data_wdata;   
//                         result  <= {8{4'h3}};  
                         result_vld      <= 1'b1;
                   end 
                   else if(data_wdata[31:4] == 28'hDEAD_000 || data_wdata[31:4] == 28'hBADBABE) begin                                 
                         trigger_o       <= 1'b1;
//                         result[63:32]   <= data_wdata;   
//                         result         <= data_wdata;  
                         result_vld        <= 1'b1;
                   end
       //            else if(pc_o == 32'h194 && data_we   && data_addr_i == 32'h003FFFDC) begin                                
                   // else if(pc_o == 32'h18e && data_we   && data_addr_i == 32'h003FFFDC) begin                                
//                   else if(pc_o == 32'h18e && data_we   && data_addr_i == 32'h003FFFEC) begin                                
//                          trigger_o      <= 1'b1;
//                          result[31:00]  <= data_wdata;   
//                          result_vld     <= 1'b1;
//                   end
                   else
                   begin
                          trigger_o      <= 1'b0;
                          // result_vld     <= 1'b0;
       
                   end
               end
//        if (~rst_ni) 
//                  result          <= {4{32'hDEAD_BEEF}};
//        else if (result_clr) 
//                  result          <= {4{32'hCAFE_BABE}}; 
      
//             if (~rst_ni) 
//                        pass      <= 1'b0;
//        else if (result_vld && 128'h69C4E0D8_6A7B0430_D8CDB780_70B4C55A == result) 
//                        pass      <= 1'b1; 
          //              else
    end

//    assign pass = (result_vld && 128'h69C4E0D8_6A7B0430_D8CDB780_70B4C55A == result) ? 1'b1 : pass;  
//    assign clk_new =  clk_i && clk_en;
    assign clk_new =  clk_i;

//     ila_0 ila_0 (
//         .clk   (clk_ila), // input wire clk
     
     
//         .probe0(result), // input wire [127:0]  probe0  
//         .probe1(data_wdata), // input wire [31:0]  probe1 
//         .probe2(pass ), // input wire [0:0]  probe2 
//         .probe3(result_vld), // input wire [0:0]  probe3 
//         .probe4(data_we   ), // input wire [0:0]  probe4 
//         .probe5(pc_o) // input wire [31:0]  probe5
//     );
         	
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
        .clk_i                  ( clk_new               ), 
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
        .fetch_enable_i         ( cpu_start             ),
        .core_sleep_o           (                       ),
        .pc_o                   ( pc_o                  )   
      );


    assign dm_halt_addr_i  = DM_HALTADDRESS;
	assign instr_addr_i	   = { {10{1'b0}}, instr_addr[RAM_ADDR_WIDTH-1:0]};
    assign data_addr_i		= data_addr;
		 
		 
	assign instr_addr_remap =  ( (instr_addr_i >= dm_halt_addr_i) &&
                                  (instr_addr_i < (dm_halt_addr_i + (2 ** DBG_ADDR_WIDTH)) ) ) ?
                                  (instr_addr_i - dm_halt_addr_i) +  2**RAM_ADDR_WIDTH - 2**DBG_ADDR_WIDTH :                                 
                                   instr_addr_i ;
	
	always_comb mem_addr_a = (mem_wen_a) ?(18'h45B2) << 2: instr_addr_remap;											   
    always_comb begin
		if ( (data_addr_i >= dm_halt_addr_i) && (data_addr_i < (dm_halt_addr_i + (2 ** DBG_ADDR_WIDTH))))
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
     logic [7:0] instr_rdata_1, instr_rdata_2, instr_rdata_3, instr_rdata_4;
     logic [7:0] data_rdata_1, data_rdata_2, data_rdata_3, data_rdata_4;

     assign instr_rdata = {instr_rdata_4, instr_rdata_3, instr_rdata_2, instr_rdata_1};
     assign data_rdata  = {data_rdata_4, data_rdata_3, data_rdata_2, data_rdata_1};	 

     
     // instantiate the ram
     
//blk_mem_gen_0 BRAM (
//       .clka        (clk_i),                // input wire clka
//       .ena         (instr_req),            // input wire ena
//       .wea         (0),                    // input wire [0 : 0] wea
//       .addra       (instr_addr_remap),     // input wire [16 : 0] addra
//       .dina        (0),                    // input wire [7 : 0] dina
//       .douta       (instr_rdata),          // output wire [31 : 0] douta
//       .clkb        (clk_i),                // input wire clkb
//       .enb         (data_req),             // input wire enb
//       .web         (data_be),              // input wire [0 : 0] web
//       .addrb       (data_addr_dec),        // input wire [16 : 0] addrb
//       .dinb        (data_wdata),           // input wire [7 : 0] dinb
//       .doutb       (data_rdata)            // output wire [31 : 0] doutb
//     );




     logic [7:0]    mem_wdata_a;
//     logic [7:0]    mem_wdata_a = 8'h01 ;

//     assign mem_addr_a = (mem_wen_a) ? 16'h45AE : instr_addr_remap;
     
//      vio_0 vio_0 (
//        .clk       (clk_i ),                // input wire clk
//        .probe_out0(mem_wdata_a),  // output wire [7 : 0] probe_out0
//        .probe_out1(mem_wen_a  ),  // output wire [0 : 0] probe_out1
//        .probe_out2(clk_en     )   // output wire [0 : 0] probe_out1
//      );
     
     dp_ram_1
        #(.ADDR_WIDTH (RAM_ADDR_WIDTH),
          .INSTR_RDATA_WIDTH(8))
     dp_ram_1
        (
         .clk           ( clk_i         ), 
//         .rst_ni        ( rst_ni          ),  
         .mem_valid_a   ( instr_req       ),
//         .mem_addr_a    ( mem_addr_a      ),//
         .mem_addr_a    ( instr_addr_remap),//instr_addr_remap
         .mem_wdata_a   ( 1'b0     ),// 1'b0
//         .mem_wdata_a   ( mem_wdata_a     ),// 1'b0
         .mem_rdata_a   ( instr_rdata_1   ),
         .mem_wen_a     ( 1'b0            ),//1'b0
//         .mem_wen_a     ( mem_wen_a       ),//1'b0
         .mem_wstrb_a   ( 1'b0            ),// 1'b0
         .mem_valid_b   ( data_req        ),
         .mem_addr_b    ( data_addr_dec   ),
         .mem_wdata_b   ( data_wdata[7:0] ),
         .mem_rdata_b   ( data_rdata_1    ),
         .mem_wen_b     ( data_we         ),
         .mem_wstrb_b   ( data_be[0]      )
          ); 

      dp_ram_2
        #(.ADDR_WIDTH (RAM_ADDR_WIDTH),
          .INSTR_RDATA_WIDTH(8))
      dp_ram_2
        (
         .clk           ( clk_new         ), 
//         .rst_ni        ( rst_ni          ),          
         .mem_valid_a   ( instr_req       ),
         .mem_addr_a    ( instr_addr_remap),
         .mem_wdata_a   ( '0              ),	// Not writing so ignored
         .mem_rdata_a   ( instr_rdata_2   ),
         .mem_wen_a     ( '0              ),
         .mem_wstrb_a   ( 1'b0            ),	// Always want 32-bits
         .mem_valid_b   ( data_req        ),
         .mem_addr_b    ( data_addr_dec   ),
         .mem_wdata_b   ( data_wdata[15:8]),
         .mem_rdata_b   ( data_rdata_2    ),
         .mem_wen_b     ( data_we         ),
         .mem_wstrb_b   ( data_be[1]      )
          );

      dp_ram_3
        #(.ADDR_WIDTH (RAM_ADDR_WIDTH),
          .INSTR_RDATA_WIDTH(8))
      dp_ram_3
        (
         .clk           ( clk_new          ), 
//         .rst_ni        ( rst_ni           ),           
         .mem_valid_a   ( instr_req        ),
         .mem_addr_a    ( instr_addr_remap ),
         .mem_wdata_a   ( '0               ),	// Not writing so ignored
         .mem_rdata_a   ( instr_rdata_3    ),
         .mem_wen_a     ( '0               ),
         .mem_wstrb_a   ( 1'b0             ),	// Always want 32-bits
         .mem_valid_b   ( data_req         ),
         .mem_addr_b    ( data_addr_dec    ),
         .mem_wdata_b   ( data_wdata[23:16]),
         .mem_rdata_b   ( data_rdata_3     ),
         .mem_wen_b     ( data_we          ),
         .mem_wstrb_b   ( data_be[2]       )
          );

      dp_ram_4
        #(.ADDR_WIDTH (RAM_ADDR_WIDTH),
          .INSTR_RDATA_WIDTH(8))
      dp_ram_4
        (
         .clk           ( clk_new          ), 
//         .rst_ni        ( rst_ni           ),            
         .mem_valid_a   ( instr_req        ),
         .mem_addr_a    ( instr_addr_remap ),
         .mem_wdata_a   ( '0               ),	// Not writing so ignored
         .mem_rdata_a   ( instr_rdata_4    ),
         .mem_wen_a     ( '0               ),
         .mem_wstrb_a   ( 1'b0             ),	// Always want 32-bits
         .mem_valid_b   ( data_req         ),
         .mem_addr_b    ( data_addr_dec    ),
         .mem_wdata_b   ( data_wdata[31:24]),
         .mem_rdata_b   ( data_rdata_4     ),
         .mem_wen_b     ( data_we          ),
         .mem_wstrb_b   ( data_be[3]       ) 
          );
              
endmodule // cv32e40x_tb_wrapper