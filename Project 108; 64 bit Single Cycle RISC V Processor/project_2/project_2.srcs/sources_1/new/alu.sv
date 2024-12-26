`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2024 00:54:40
// Design Name: 
// Module Name: alu
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


module alu (
    input logic [63:0] i_a,          // First operand
    input logic [63:0] i_b,          // Second operand
    input logic [3:0] i_alu_ctrl,     // ALU control signals
    output logic [63:0] o_result,     // Result output
    output logic o_zero               // Zero flag
);
    always_comb begin
        case (i_alu_ctrl)
            4'b0000: o_result = i_a + i_b;         // Addition
            4'b0001: o_result = i_a - i_b;         // Subtraction
            4'b0010: o_result = i_a & i_b;         // AND
            4'b0011: o_result = i_a | i_b;         // OR
            4'b0100: o_result = i_a ^ i_b;         // XOR
            4'b0101: o_result = ~(i_a | i_b);      // NOR
            4'b0110: o_result = i_a << 1;          // Shift left
            4'b0111: o_result = i_a >> 1;          // Shift right
            default: o_result = 64'b0;              // Default case
        endcase
        
        o_zero = (o_result == 64'b0);               // Set zero flag if result is zero
    end
endmodule

