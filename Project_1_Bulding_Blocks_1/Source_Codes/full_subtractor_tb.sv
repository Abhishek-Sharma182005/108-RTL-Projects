`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 18:32:35
// Design Name: 
// Module Name: full_subtractor_tb
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


module full_subtractor_tb(

    ); logic A, B, Bin;
    logic Diff, Bout;

    full_subtractor uut (
        .A(A),
        .B(B),
        .Bin(Bin),
        .Diff(Diff),
        .Bout(Bout)
    );

    initial begin
        // Test vectors
        A = 0; B = 0; Bin = 0;
        #10 A = 0; B = 1; Bin = 0;
        #10 A = 1; B = 0; Bin = 0;
        #10 A = 1; B = 1; Bin = 0;
        #10 A = 0; B = 0; Bin = 1;
        #10 A = 0; B = 1; Bin = 1;
        #10 A = 1; B = 0; Bin = 1;
        #10 A = 1; B = 1; Bin = 1;
        #10 $stop;
    end
endmodule
