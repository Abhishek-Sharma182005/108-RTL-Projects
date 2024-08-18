`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 18:50:03
// Design Name: 
// Module Name: full_adder
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


module full_adder(
  input logic A,
    input logic B,
    input logic Cin,
    output logic Sum,
    output logic Cout
);
    assign Sum = A ^ B ^ Cin;            // XOR for Sum
    assign Cout = (A & B) | (Cin & (A ^ B)); // AND-OR for Carry
endmodule
