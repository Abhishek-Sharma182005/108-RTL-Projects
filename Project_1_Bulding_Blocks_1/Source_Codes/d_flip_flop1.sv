`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 21:48:20
// Design Name: 
// Module Name: d_flip_flop1
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


module d_flip_flop1(

  input logic D,
    input logic clk,
    output logic Q
);
    always_ff @(posedge clk) begin
        Q <= D;
    end
endmodule
