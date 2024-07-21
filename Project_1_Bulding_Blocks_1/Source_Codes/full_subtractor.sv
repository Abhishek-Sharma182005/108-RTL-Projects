`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 18:30:16
// Design Name: 
// Module Name: full_subtractor
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


module full_subtractor(
input logic A,
    input logic B,
    input logic Bin,
    output logic Diff,
    output logic Bout
);
    assign Diff = A ^ B ^ Bin;         // XOR for Difference
    assign Bout = (~A & B) | (Bin & (~A ^ B)); // AND-OR for Borrow
endmodule
