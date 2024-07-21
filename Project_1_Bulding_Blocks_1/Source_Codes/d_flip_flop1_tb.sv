`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 21:48:47
// Design Name: 
// Module Name: d_flip_flop1_tb
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


module d_flip_flop1_tb(

    );
    logic D, clk;
    logic Q;

    d_flip_flop1 uut (
        .D(D),
        .clk(clk),
        .Q(Q)
    );

    initial begin
        // Initialize clock
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Test vectors
        D = 0;
        #10 D = 1;
        #10 D = 0;
        #10 D = 1;
        #10 $stop;
    end
endmodule
