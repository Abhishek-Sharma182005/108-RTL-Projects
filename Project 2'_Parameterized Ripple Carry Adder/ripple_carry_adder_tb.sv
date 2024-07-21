`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 15:46:08
// Design Name: 
// Module Name: ripple_carry_adder_tb
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


module ripple_carry_adder_tb;

  // Parameter for the bit-width
    parameter N = 8;

    // Testbench signals
    logic [N-1:0] A, B;
    logic [N-1:0] Sum;
    logic Cout;

    // Instantiate the Ripple Carry Adder
    ripple_carry_adder #(N) uut (
        .A(A),
        .B(B),
        .Sum(Sum),
        .Cout(Cout)
    );

    // Stimulus block
    initial begin
        // Initialize inputs
        A = 0;
        B = 0;

        // Apply test vectors
        #10 A = 8'b00001111; B = 8'b00000001;  // Test case 1
        #10 A = 8'b11110000; B = 8'b00001111;  // Test case 2
        #10 A = 8'b10101010; B = 8'b01010101;  // Test case 3
        #10 A = 8'b11111111; B = 8'b11111111;  // Test case 4
        #10 A = 8'b10000001; B = 8'b10000001;  // Test case 5

        // End simulation
        #10 $stop;
    end

    // Monitor block to display results
    initial begin
        $monitor("Time=%0t : A=%b B=%b => Sum=%b Cout=%b", $time, A, B, Sum, Cout);
    end

endmodule


