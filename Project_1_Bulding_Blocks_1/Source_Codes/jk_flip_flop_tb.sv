`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 11:10:25
// Design Name: 
// Module Name: jk_flip_flop_tb
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


module jk_flip_flop_tb(

    );
    
        logic J, K, clk;
    logic Q;

    jk_flip_flop uut (
        .J(J),
        .K(K),
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
        J = 0; K = 0;
        #10 J = 1; K = 0;
        #10 J = 0; K = 1;
        #10 J = 1; K = 1;
        #10 $stop;
    end
endmodule
