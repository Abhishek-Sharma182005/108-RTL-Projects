`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 19:07:03
// Design Name: 
// Module Name: half_adder
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


module half_adder(

    input logic A,
    input logic B,
    output logic Sum,
    output logic Carry
);
    assign Sum = A ^ B;     // XOR for Sum
    assign Carry = A & B;   // AND for Carry
endmodule
