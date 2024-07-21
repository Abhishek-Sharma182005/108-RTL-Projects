`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 18:50:53
// Design Name: 
// Module Name: full_adder_tb
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


module full_adder_tb(

    ); logic A, B, Cin;
    logic Sum, Cout;

    full_adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        // Test vectors
        A = 0; B = 0; Cin = 0;
        #10 A = 0; B = 1; Cin = 0;
        #10 A = 1; B = 0; Cin = 0;
        #10 A = 1; B = 1; Cin = 0;
        #10 A = 0; B = 0; Cin = 1;
        #10 A = 0; B = 1; Cin = 1;
        #10 A = 1; B = 0; Cin = 1;
        #10 A = 1; B = 1; Cin = 1;
        #10 $stop;
    end
endmodule
