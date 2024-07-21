`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 11:57:12
// Design Name: 
// Module Name: counter_4bit_tb
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


module counter_4bit_tb(

    );   logic clk, reset;
    logic [3:0] count;

    counter_4bit uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    initial begin
        // Initialize clock
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Test vectors
        reset = 1; #10; // Reset counter
        reset = 0;
        #100 $stop; // Run simulation for 100 time units
    end
endmodule
