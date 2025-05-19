`timescale 1 ns / 1 ps

module RISC_BENCHMARK_IP
  (
  
  input         clk        ,
  input         cpu_rst    ,
  input         cpu_start  ,
  output        result_vld ,      
  output  [31:0]MSB_Bits       
   );
   
   parameter INSTR_RDATA_WIDTH = 32; //128;
   parameter RAM_ADDR_WIDTH    = 17; //22;//18; //14 works as as well
   parameter BOOT_ADDR         = 'h80; //80;
   
   //------------------------------------------------
    wire         clk_i;
    wire         cpu_stalled;
    wire         trig_op;
    wire [31:0]  result;
    assign clk_i = clk;
   //------------------------------------------------
//     clk_wiz_0 clk_wiz_0
//    (

//     .clk_out   (clk_i  ),       // output clk_out
//     .resetn    (1'b1   ),       // cpu_rst
//     .clk_in1   (clk    ));      // input clk_in1
    
    
    
//     ila_0 ila_0 (
//         .clk   (cv32e40x_wrapper_i.clk_ila), // input wire clk   
     
//         .probe0(cv32e40x_wrapper_i.result), // input wire [127:0]  probe0  
//         .probe1(cv32e40x_wrapper_i.data_wdata), // input wire [31:0]  probe1 
//         .probe2(cv32e40x_wrapper_i.cpu_start ), // input wire [0:0]  probe2 
//         .probe3(cv32e40x_wrapper_i.result_vld), // input wire [0:0]  probe3 
//         .probe4(cv32e40x_wrapper_i.data_we   ), // input wire [0:0]  probe4 
//         .probe5(cv32e40x_wrapper_i.pc_o) // input wire [31:0]  probe5
//     );
     
//          ila_1 ila_0 (
//         .clk   (cv32e40x_wrapper_i.clk_ila), // input wire clk       
//         .probe0(cv32e40x_wrapper_i.pass)     // input wire [127:0]  probe0  
//     );
//     wire rst_cpu;
     
//       vio_0 vio_0 (
//           .clk       (clk_i ),                // input wire clk
//           .probe_out0(mem_wdata_a),  // output wire [7 : 0] probe_out0
//           .probe_out1(mem_wen_a  ),  // output wire [0 : 0] probe_out1
//           .probe_out2(clk_en     ),  // output wire [0 : 0] probe_out1
//           .probe_out3(rst_cpu                       )  // output wire [0 : 0] probe_out1
//         );

//        vio_1 vio_1 (
//        .clk       (clk_i       ), // input wire clk
//        .probe_out0(rst_cpu     )  // output wire [0 : 0] probe_out1
//      );
    cv32e40x_wrapper
         #(.INSTR_RDATA_WIDTH (INSTR_RDATA_WIDTH),
           .RAM_ADDR_WIDTH    (RAM_ADDR_WIDTH),
           .BOOT_ADDR         (BOOT_ADDR),
           .DM_HALTADDRESS    (32'h1A11_0800),
           .HART_ID           (32'h0000_0000),
           .NUM_MHPMCOUNTERS  (0)
          )
    cv32e40x_wrapper_i
         (.clk_i          ( clk_i       ),
          .clk_ila        ( clk         ),//
//          .pass           ( pass        ),//
          .rst_ni         ( cpu_rst     ),//cpu_rst
//          .rst_ni         ( cpu_rst|(!rst_cpu) ),//cpu_rst
          .fetch_enable_i ( 1'b1        ),
          .cpu_start      ( cpu_start   ), //added //cpu_start
          .trigger_o      (             ), //added
          .result         ( result      ), //added
          .result_vld     ( result_vld  )  //added
          );
//   assign pass = 1'b1;       
//   assign pass = (128'h69C4E0D8_6A7B0430_D8CDB780_70B4C55A == result);       
//   assign MSB_Bits = result [127:96];       
   assign MSB_Bits = result [31:0];       
endmodule