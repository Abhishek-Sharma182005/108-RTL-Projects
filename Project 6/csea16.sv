`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: abhishek sharma
// 
// Create Date: 18.08.2024 15:24:38
// Design Name: 
// Module Name: csea16
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
module csea16 (
    input  logic [15:0] A, B,
    input  logic Cin,
    output logic [15:0] Sum,
    output logic Cout
);

    logic [3:0] Sum0_0, Sum0_1, Sum1_0, Sum1_1, Sum2_0, Sum2_1;
    logic c4, g4, p4;
    logic c8, g8, p8;
    logic c12, g12, p12;
    logic w1, w2, w3;

    // Instantiate 4-bit ripple carry adders
    rca4 rca1 (
        .Sum(Sum[3:0]),
        .Cout(c4),
        .A(A[3:0]),
        .B(B[3:0]),
        .Cin(Cin)
    );

    rca4 rca2 (
        .Sum(Sum0_0),
        .Cout(g4),
        .A(A[7:4]),
        .B(B[7:4]),
        .Cin(1'b0)
    );

    rca4 rca3 (
        .Sum(Sum0_1),
        .Cout(p4),
        .A(A[7:4]),
        .B(B[7:4]),
        .Cin(1'b1)
    );

    rca4 rca4 (
        .Sum(Sum1_0),
        .Cout(g8),
        .A(A[11:8]),
        .B(B[11:8]),
        .Cin(1'b0)
    );

    rca4 rca5 (
        .Sum(Sum1_1),
        .Cout(p8),
        .A(A[11:8]),
        .B(B[11:8]),
        .Cin(1'b1)
    );

    rca4 rca6 (
        .Sum(Sum2_0),
        .Cout(g12),
        .A(A[15:12]),
        .B(B[15:12]),
        .Cin(1'b0)
    );

    rca4 rca7 (
        .Sum(Sum2_1),
        .Cout(p12),
        .A(A[15:12]),
        .B(B[15:12]),
        .Cin(1'b1)
    );

    // Carry Skip Logic
    and a1 (w1, c4, p4);
    or  o1 (c8, w1, g4);
    mux21x4 mux1 (
        .Y(Sum[7:4]),
        .A0(Sum0_0),
        .A1(Sum0_1),
        .S(c4)
    );

    and a2 (w2, c8, p8);
    or  o2 (c12, w2, g8);
    mux21x4 mux2 (
        .Y(Sum[11:8]),
        .A0(Sum1_0),
        .A1(Sum1_1),
        .S(c8)
    );

    and a3 (w3, c12, p12);
    or  o3 (Cout, w3, g12);
    mux21x4 mux3 (
        .Y(Sum[15:12]),
        .A0(Sum2_0),
        .A1(Sum2_1),
        .S(c12)
    );

endmodule // csea16
module rca4 (
    input  logic [3:0] A, B,
    input  logic Cin,
    output logic [3:0] Sum,
    output logic Cout
);

    logic [3:0] carry;

    FullAdder fa0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(Sum[0]),
        .Cout(carry[0])
    );

    FullAdder fa1 (
        .A(A[1]),
        .B(B[1]),
        .Cin(carry[0]),
        .Sum(Sum[1]),
        .Cout(carry[1])
    );

    FullAdder fa2 (
        .A(A[2]),
        .B(B[2]),
        .Cin(carry[1]),
        .Sum(Sum[2]),
        .Cout(carry[2])
    );

    FullAdder fa3 (
        .A(A[3]),
        .B(B[3]),
        .Cin(carry[2]),
        .Sum(Sum[3]),
        .Cout(Cout)
    );

endmodule // rca4
module FullAdder (
    input  logic A,
    input  logic B,
    input  logic Cin,
    output logic Sum,
    output logic Cout
);

    assign Sum  = A ^ B ^ Cin;
    assign Cout = (A & B) | (Cin & (A ^ B));

endmodule // FullAdder
module mux21x4 (
    input  logic [3:0] A0, A1,
    input  logic S,
    output logic [3:0] Y
);

    assign Y = S ? A1 : A0;

endmodule // mux21x4
