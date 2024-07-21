`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 22:04:07
// Design Name: 
// Module Name: t_flip_flop
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


module t_flip_flop(
input logic T,
    input logic clk,
    input logic rst,  // Add reset signal
    output logic Q
    );
      always_ff @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 0;  // Initialize Q to 0 on reset
        else if (T)
            Q <= ~Q;
    end
 
endmodule
