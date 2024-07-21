`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 20:44:04
// Design Name: 
// Module Name: logic_gates_NAND
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


module logic_gates_NAND(
 input logic A,
    input logic B,
    output logic AND_out,
    output logic OR_out,
    output logic NOT_out,
    output logic NAND_out,
    output logic NOR_out,
    output logic XOR_out,
    output logic XNOR_out

    );
    // NAND gate
    assign NAND_out = ~(A & B);

    // NOT gate using NAND
    assign NOT_out = ~(A & A);
    
    // AND gate using NAND
    assign AND_out = ~(~(A & B) & ~(A & B));
    
    // OR gate using NAND
    assign OR_out = ~(~A & ~B);
    assign NOR_out = ~(A | B);
    // XOR gate using NAND
   logic n1, n2, n3, n4;

    // XOR using NAND gates
    assign n1 = ~(A & B);
    assign n2 = ~(A & n1);
    assign n3 = ~(B & n1);
    assign XOR_out = ~(n2 & n3);

    // XNOR using NAND gates
    assign XNOR_out = ~(XOR_out);
endmodule
