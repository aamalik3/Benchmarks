`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dr. Aysu Research
// Engineer:  John Buchanan
// 
// Create Date: 05/04/2024 12:08:49 PM
// Design Name: 
// Module Name: _4x4Matrix
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


module Scalable_Matrix(
    input clk, reset,
    output reg [35:0] temp_result,
    output wire [17:0] matrix_A_value, matrix_B_value,
    output reg [17:0] row_index, col_index, gen_index, result_index,
    output reg [17:0] col_index_offset, result_index_offset,
    output reg done
    );

//local parameters
//------- ONLY UPDATE THIS ONE !!!!!!!----------------
localparam SIZE_OF_ROW = 'd316;                                          //adjust this to the size of the width of the matrix
// ---------------------------------------------------

//----------- DO NOT TOUCH ---------------------------
localparam ALWAYS = 1'b1;
localparam ONE = 'h000000000000000000000000000000001;
localparam FULL_SIZE = (SIZE_OF_ROW * SIZE_OF_ROW) - 1'b1;              // the area of the matrix MINUS ONE!!!!
//----------------------------------------------------

//initialize values
reg [7:0] result [3:0];
//reg [7:0] temp_result;
//reg [3:0] matrix_A_value, matrix_B_value;
//reg [2:0] row_index, col_index, gen_index, result_index;
//reg [1:0] col_index_offset, result_index_offset;
reg clock_cycle_delay;
wire not_used;

//code
bram_A mat_A (
  .clka(clk),               // input wire clka
  .ena(ALWAYS),             // input wire ena
  .addra(row_index),        // input wire [13 : 0] addra
  .douta(matrix_A_value)    // output wire [15 : 0] douta
);

bram_B mat_B (
  .clka(clk),               // input wire clka
  .ena(ALWAYS),             // input wire ena
  .addra(col_index),        // input wire [13 : 0] addra
  .douta(matrix_B_value)    // output wire [15 : 0] douta
);

//bram_result mat_result (
//  .clka(clk),    // input wire clka
//  .ena(ALWAYS),      // input wire ena
//  .wea(gen_index == ONE),      // input wire [0 : 0] wea
//  .addra(result_index),  // input wire [16 : 0] addra
//  .dina(temp_result),    // input wire [38 : 0] dina
//  .douta(not_used)  // output wire [38 : 0] douta
//);

always @(posedge clk) begin
    if(reset | done) begin                                                                 //clear the registers
        row_index <= 0;
        col_index <= 0;
        result_index <= 0;
        gen_index <= 0;
        col_index_offset <= 0;
        temp_result <= 0;
        result_index_offset <= 0;
        clock_cycle_delay <= 0;
//        col_num <= 0;
        done <= 0;
    end else begin
        if(clock_cycle_delay == 0) begin                                                //needed to load from bram
            clock_cycle_delay <= 1;
        end else begin
            clock_cycle_delay <= 0;
            row_index <= row_index + 1;                                                 //increment row index
            gen_index <= gen_index + 1;                                                 //increment gen index
            col_index <= col_index_offset + (gen_index * SIZE_OF_ROW);                    //increment column index with offset
            temp_result <= temp_result + (matrix_A_value * matrix_B_value);             //store values into temp result
            if(row_index != FULL_SIZE) begin                                            //row_index will count from 0-15 continuosly
                if(gen_index == SIZE_OF_ROW - 1) begin                                  //if we reach the end of the row, that matrix multiplcation is done and we should reset gen index and store the result
                    gen_index <= 0;
                    result[result_index] <= temp_result;                                               //clear temp_result
//                    col_num <= 0;
                end
                else begin
//                    col_num <= col_num + 1;
                end
                if (gen_index == ONE) begin
                    temp_result <= 0;
                    if(temp_result != 0) begin
                        result_index <= row_index + result_index_offset - 1;                //store row index into result index and add the offset 
                    end

                end
            end else begin                                                          //after row_index has counted to 15, restart and adjust column index
                row_index <= 0;                                              
                gen_index <= 0;
                //result_index <= row_index + result_index_offset + 1;    
                
            end
            if(row_index == FULL_SIZE - 1) begin                                    //update offsets a clock edge early too accurately update indexies
                col_index_offset <= col_index_offset + 1;                           // add offset to the column
                result_index_offset <= result_index_offset + 1; 
            end
            if(result_index == FULL_SIZE & row_index == ONE) begin
                done <= 1'b1;
            end
        end
    end
end
endmodule
