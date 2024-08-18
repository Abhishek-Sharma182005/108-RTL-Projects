`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 11:29:11
// Design Name: 
// Module Name: master_slave_jk_flip_flop_tb
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


module master_slave_jk_flip_flop_tb(

    );
    logic J, K, clk, reset;
    logic Q;

    master_slave_jk_flip_flop uut (
        .J(J),
        .K(K),
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );

    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Testbench procedure
    initial begin
        // Initialize inputs
        J = 0; K = 0;
        reset = 1;
        #10 reset = 0;  // Release reset after 10ns

        // Apply test vectors
        J = 1; K = 0;  // Set state
        #20;
        J = 0; K = 1;  // Reset state
        #20;
        J = 1; K = 1;  // Toggle state
        #20;

        $stop;  // Stop simulation
    end
endmodule
