`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 20:11:47
// Design Name: 
// Module Name: logic_gates
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


module logic_gates( input logic A,
    input logic B,
    output logic AND_out,
    output logic OR_out,
    output logic NOT_out,
    output logic NAND_out,
    output logic NOR_out,
    output logic XOR_out,
    output logic XNOR_out
);
    // Traditional implementation
    assign AND_out = A & B;
    assign OR_out = A | B;
    assign NOT_out = ~A;
    assign NAND_out = ~(A & B);
    assign NOR_out = ~(A | B);
    assign XOR_out = A ^ B;
    assign XNOR_out = ~(A ^ B);

  
endmodule
