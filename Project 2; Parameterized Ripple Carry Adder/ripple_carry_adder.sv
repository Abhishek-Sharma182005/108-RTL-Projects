`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 15:39:12
// Design Name: 
// Module Name: ripple_carry_adder
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


module ripple_carry_adder #(parameter N = 4) (
    input logic [N-1:0] A,  // N-bit input A
    input logic [N-1:0] B,  // N-bit input B
    output logic [N-1:0] Sum, // N-bit Sum output
    output logic Cout // Carry Out
);
    logic [N-1:0] Carry; // Internal Carry bits

    // Generate Full Adders for each bit
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : full_adder_gen
            if (i == 0) begin
                full_adder fa (
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(0),
                    .Sum(Sum[i]),
                    .Cout(Carry[i])
                );
            end else begin
                full_adder fa (
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(Carry[i-1]),
                    .Sum(Sum[i]),
                    .Cout(Carry[i])
                );
            end
        end
    endgenerate

    assign Cout = Carry[N-1];

endmodule

// Full Adder Module
module full_adder (
    input logic A,
    input logic B,
    input logic Cin,
    output logic Sum,
    output logic Cout
);
    assign Sum = A ^ B ^ Cin;  // XOR for Sum
    assign Cout = (A & B) | (Cin & (A ^ B)); // AND-OR for Carry
endmodule


