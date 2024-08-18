module csa16a (
    output logic [15:0] Sum,
    output logic Cout,
    input  logic [15:0] A,
    input  logic [15:0] B,
    input  logic Cin
);

    logic c4, c7, c12;
    logic [3:0] p1, p2;
    logic w1, w2, w3, w4;

    // Instantiate 4-bit ripple carry adders
    rca4 cpa1 (.Sum(Sum[3:0]),   .Cout(c4),   .A(A[3:0]),   .B(B[3:0]),   .Cin(Cin));
    rca4p cpa2 (.Sum(Sum[7:4]),  .Cout(w1),   .P(p1),       .A(A[7:4]),   .B(B[7:4]),   .Cin(c4));
    rca4p cpa3 (.Sum(Sum[11:8]), .Cout(w3),   .P(p2),       .A(A[11:8]),  .B(B[11:8]),  .Cin(c7));
    rca4 cpa4 (.Sum(Sum[15:12]), .Cout(Cout), .A(A[15:12]), .B(B[15:12]), .Cin(c12));

    // Carry skip logic
    and a1 (w2, p1[0], p1[1], p1[2], p1[3], c4);
    or  o1 (c7, w1, w2);
    and a2 (w4, p2[0], p2[1], p2[2], p2[3], c7);
    or  o2 (c12, w3, w4);

endmodule

// 4-bit Ripple Carry Adder without Propagate Logic
module rca4 (
    output logic [3:0] Sum,
    output logic Cout,
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic Cin
);

    logic [3:0] C;

    // Full Adders for each bit
    FullAdder fa0 (.A(A[0]), .B(B[0]), .Cin(Cin),  .Sum(Sum[0]), .Cout(C[0]));
    FullAdder fa1 (.A(A[1]), .B(B[1]), .Cin(C[0]), .Sum(Sum[1]), .Cout(C[1]));
    FullAdder fa2 (.A(A[2]), .B(B[2]), .Cin(C[1]), .Sum(Sum[2]), .Cout(C[2]));
    FullAdder fa3 (.A(A[3]), .B(B[3]), .Cin(C[2]), .Sum(Sum[3]), .Cout(Cout));

endmodule

// 4-bit Ripple Carry Adder with Propagate Logic
module rca4p (
    output logic [3:0] Sum,
    output logic Cout,
    output logic [3:0] P,
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic Cin
);

    logic [3:0] C;

    // Full Adders for each bit
    FullAdder fa0 (.A(A[0]), .B(B[0]), .Cin(Cin),  .Sum(Sum[0]), .Cout(C[0]));
    FullAdder fa1 (.A(A[1]), .B(B[1]), .Cin(C[0]), .Sum(Sum[1]), .Cout(C[1]));
    FullAdder fa2 (.A(A[2]), .B(B[2]), .Cin(C[1]), .Sum(Sum[2]), .Cout(C[2]));
    FullAdder fa3 (.A(A[3]), .B(B[3]), .Cin(C[2]), .Sum(Sum[3]), .Cout(Cout));

    // Propagate logic
    assign P = A ^ B;

endmodule

// Full Adder Module
module FullAdder (
    input  logic A,
    input  logic B,
    input  logic Cin,
    output logic Sum,
    output logic Cout
);

    // Full adder logic
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (Cin & (A ^ B));

endmodule
