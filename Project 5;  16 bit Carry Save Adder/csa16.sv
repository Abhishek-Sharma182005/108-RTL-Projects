`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2024 14:32:08
// Design Name: 
// Module Name: csa16
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

module csa16 (
    input  logic [15:0] A,
    input  logic [15:0] B,
    input  logic       Cin,
    output logic [15:0] Sum,
    output logic       Cout
);

    logic [3:0] P_block; // Block propagate signals
    logic [3:0] G_block; // Block generate signals
    logic [3:0] C;       // Carry signals between blocks
    logic [15:0] Sum_internal;

    // Instantiate 4-bit Carry Skip Adders
    csa04 csa0 (A[3:0], B[3:0], Cin, Sum_internal[3:0], C[0]);
    csa04 csa1 (A[7:4], B[7:4], C[0], Sum_internal[7:4], C[1]);
    csa04 csa2 (A[11:8], B[11:8], C[1], Sum_internal[11:8], C[2]);
    csa04 csa3 (A[15:12], B[15:12], C[2], Sum_internal[15:12], C[3]);

    // Calculate block propagate signals
    assign P_block[0] = &A[3:0] & &B[3:0];
    assign P_block[1] = &A[7:4] & &B[7:4];
    assign P_block[2] = &A[11:8] & &B[11:8];
    assign P_block[3] = &A[15:12] & &B[15:12];

    // Calculate block generate signals
    assign G_block[0] = |(A[3:0] & B[3:0]);
    assign G_block[1] = |(A[7:4] & B[7:4]);
    assign G_block[2] = |(A[11:8] & B[11:8]);
    assign G_block[3] = |(A[15:12] & B[15:12]);

    // Carry-out logic
    assign Cout = P_block[3] ? Cin : C[3];
    assign Sum = Sum_internal;

endmodule
module csa04 (
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic      Cin,
    output logic [3:0] Sum,
    output logic      Cout
);

    logic [3:0] P, G;
    logic [3:0] C;
    logic       P_block;

    // Generate Propagate and Generate signals
    assign P = A ^ B;         // Propagate
    assign G = A & B;         // Generate

    // Carry-in for each bit
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & C[1]);
    assign C[3] = G[2] | (P[2] & C[2]);

    // Sum calculation
    assign Sum = P ^ C[3:0];

    // Block propagate signal (all propagate signals are 1)
    assign P_block = &P;

    // Carry-out calculation
    assign Cout = P_block ? Cin : C[3];

endmodule


