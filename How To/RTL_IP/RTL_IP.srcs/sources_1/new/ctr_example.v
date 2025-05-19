`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2024 12:59:10 PM
// Design Name: 
// Module Name: ctr_example
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


module ctr_example(
    input               clk,
    input               rst,
    input               enable,
    output reg  [31:0]  ctr_val
    );
    
    always@(posedge clk) 
    begin
    if (!rst)
        begin
         ctr_val <= 'd0;
        end
    else
    begin    
        if (enable && ctr_val < 32'hFFFF_FFFF)
            ctr_val <=ctr_val+1;
        else
            ctr_val<=ctr_val;
        end
    end    
endmodule