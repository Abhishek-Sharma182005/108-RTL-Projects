`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 11:18:47
// Design Name: 
// Module Name: sr_flip_flop
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


module sr_flip_flop(
input logic S,
    input logic R,
    input logic clk,
    output logic Q
    );
    always_ff @(posedge clk) begin
        if (S && ~R)
            Q <= 1;               // Set
        else if (~S && R)
            Q <= 0;               // Reset
        else if (S && R)
            Q <= 1'bx;            // Invalid state
    end
endmodule
