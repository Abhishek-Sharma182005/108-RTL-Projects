`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 20:45:34
// Design Name: 
// Module Name: logic_gates_NAND_tb
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


module logic_gates_NAND_tb;
     logic A, B;
    logic AND_out, OR_out, NOT_out, NAND_out, NOR_out, XOR_out, XNOR_out;

    logic_gates_NAND uut (
        .A(A),
        .B(B),
        .AND_out(AND_out),
        .OR_out(OR_out),
        .NOT_out(NOT_out),
        .NAND_out(NAND_out),
        .NOR_out(NOR_out),
        .XOR_out(XOR_out),
        .XNOR_out(XNOR_out)
    );

    initial begin
        // Test vectors
        A = 0; B = 0;
        #10 A = 0; B = 1;
        #10 A = 1; B = 0;
        #10 A = 1; B = 1;
        #10 $stop;
    end
endmodule
