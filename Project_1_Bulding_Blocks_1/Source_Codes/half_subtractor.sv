`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 18:38:36
// Design Name: 
// Module Name: half_subtractor
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


module half_subtractor(
input logic A,
    input logic B,
    output logic Diff,
    output logic Borrow
);
    assign Diff = A ^ B;           // XOR for Difference
    assign Borrow = ~A & B;        // AND-NOT for Borrow
endmodule
