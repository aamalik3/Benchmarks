`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2023 05:21:38 PM
// Design Name: 
// Module Name: tb_clockgate
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


module tb_clockgate(

    );
    
  reg clk_i=0;  
    wire clk_o;
     CLK_Gate CLK_Gate(
        .clk_i( clk_i),
        .enb( 1),
        .clk_o(clk_o)
        );
        initial
        begin
         forever
            clk_i = #1 ~clk_i;      
        
        end
        
        
endmodule
