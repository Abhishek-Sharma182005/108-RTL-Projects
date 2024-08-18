`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: abhishek sharma
// 
// Create Date: 18.08.2024 15:25:21
// Design Name: 
// Module Name: csea16tb
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


module csea16tb;

    logic [15:0] A, B;
    logic Cin;
    logic [15:0] Sum;
    logic Cout;

    // Instantiate the Carry Skip Adder
    csea16 uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    // Test sequence
    initial begin
        // Apply test vectors
        A = 16'h0000; B = 16'h0000; Cin = 0;
        #10; // Wait for 10 time units
        $display("A = %h, B = %h, Cin = %b, Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);

        A = 16'hFFFF; B = 16'h0001; Cin = 0;
        #10; // Wait for 10 time units
        $display("A = %h, B = %h, Cin = %b, Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);

        A = 16'h1234; B = 16'h5678; Cin = 1;
        #10; // Wait for 10 time units
        $display("A = %h, B = %h, Cin = %b, Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);

        A = 16'hFFFF; B = 16'hFFFF; Cin = 1;
        #10; // Wait for 10 time units
        $display("A = %h, B = %h, Cin = %b, Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);

        // Finish the simulation
        $finish;
    end

endmodule // tb_csea16
