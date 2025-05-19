`timescale 1ns / 1ps

module test_4x4;

    // Constants
    localparam CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk;
    reg reset;
    
    wire [39:0] temp_result;
    wire [19:0] matrix_A_value, matrix_B_value;
    wire [15:0] row_index, col_index, gen_index, result_index, col_num;
    wire [15:0] col_index_offset, result_index_offset;
    wire [7:0] data_result;
    
    // Instantiate the DUT
    Scalable_Matrix DUT (
        .clk(clk),
        .reset(reset),
        .temp_result(temp_result),
        .matrix_A_value(matrix_A_value),
        .matrix_B_value(matrix_B_value),
        .row_index(row_index),
        .col_index(col_index),
        .gen_index(gen_index),
        .col_num(col_num),
        .result_index(result_index),
        .col_index_offset(col_index_offset),
        .result_index_offset(result_index_offset),
        .data_result(data_result)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Initial reset
    initial begin
        clk = 0;
        reset = 1;
        #20;
        reset = 0;
    end
    
    // Stimulus generation
    initial begin
        #100;
        if(result_index == 'd15) begin
            $stop();
        end
        #1000;
        $finish;
    end
    
    // Display outputs
    always @(posedge clk) begin
        // Display outputs here
        
        // Example: Displaying temp_result
        $display("temp_result = %d", temp_result);
        
        // Similarly, display other outputs
        
    end
    
endmodule
