`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2024 11:49:49
// Design Name: 
// Module Name: bclg32
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





module bclg32(
    input  logic [31:0] A,
    input  logic [31:0] B,
    input  logic      Cin,
    output logic [31:0] Sum,
    output logic     Cout
);

    logic [1:0]  C;
    logic [15:0] Sum0, Sum1;

    CLA_16bit cla0 (A[15:0], B[15:0], Cin, Sum0,C[0]);
    CLA_16bit cla1 (A[31:16], B[31:16], C[0], Sum1,C[1]);

  

    assign Sum = {Sum1, Sum0};
    assign Cout = C[1];

endmodule

