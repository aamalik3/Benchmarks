`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2023 12:49:04 PM
// Design Name: 
// Module Name: CUSTOM_IPS
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module CUSTOM_IPS
  (
  
  input         clock      ,
  input         reset      ,
  output  [7:0] Output_1   ,      
  output  [31:0]Output_Bus       
   );
 wire [31:0 ]ctr_val;  

    
    ctr_example ctr_example(
        .clk    (clock),
        .rst    (reset),
        .enable (1'b1),
        .ctr_val(ctr_val)
        );
        
  
        
assign Output_Bus = ctr_val;
assign Output_1   = ctr_val[31:24];
endmodule