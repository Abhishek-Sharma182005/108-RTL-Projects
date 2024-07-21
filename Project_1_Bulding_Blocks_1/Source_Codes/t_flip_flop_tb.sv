`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 22:04:41
// Design Name: 
// Module Name: t_flip_flop_tb
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


module t_flip_flop_tb;
    logic T, clk, rst;
    logic Q;
     t_flip_flop uut (
        .T(T),
        .clk(clk),
        .rst(rst),  // Connect reset signal
        .Q(Q)
    );

 initial begin
        // Initialize clock
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize reset and apply it initially
        rst = 1;
        #10 rst = 0;

        // Test vectors
        T = 0;
        #10 T = 1;
        #10 T = 0;
        #10 T = 1;
        #10 $stop;
    end
endmodule
