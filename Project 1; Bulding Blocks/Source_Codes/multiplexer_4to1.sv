`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 21:18:57
// Design Name: 
// Module Name: multiplexer_4to1
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


module multiplexer_4to1(
input logic [3:0] in,
    input logic [1:0] sel,
    output logic out
    );
  assign out = (sel == 2'b00) ? in[0] :
                 (sel == 2'b01) ? in[1] :
                 (sel == 2'b10) ? in[2] :
                 (sel == 2'b11) ? in[3] :
                 1'b0; // Default case (optional, to handle invalid `sel` values)
endmodule

