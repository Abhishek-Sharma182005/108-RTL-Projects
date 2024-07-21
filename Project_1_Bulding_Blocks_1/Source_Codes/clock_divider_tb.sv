`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 12:45:53
// Design Name: 
// Module Name: clock_divider_tb
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


module clock_divider_tb(

    );logic clk_in, reset;
    logic clk_out;

    clock_divider #(.DIVISOR(25)) uut (
        .clk_in(clk_in),
        .reset(reset),
        .clk_out(clk_out)
    );

    initial begin
        // Initialize clock
        clk_in = 0;
        forever #1 clk_in = ~clk_in; // 2 time units per clock cycle
    end

    initial begin
        // Test vectors
        reset = 1; #10; // Reset clock divider
        reset = 0;
        #200 $stop; // Run simulation for 200 time units
    end
endmodule
