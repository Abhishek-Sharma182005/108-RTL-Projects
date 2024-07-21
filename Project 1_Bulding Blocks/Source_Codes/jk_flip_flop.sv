`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 11:08:16
// Design Name: 
// Module Name: jk_flip_flop
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


module jk_flip_flop(
    
     input logic J,
    input logic K,
    input logic clk,
    output logic Q
);
    always_ff @(posedge clk) begin
        case ({J, K})
            2'b00: Q <= Q;        // No change
            2'b01: Q <= 0;        // Reset
            2'b10: Q <= 1;        // Set
            2'b11: Q <= ~Q;       // Toggle
        endcase
    end
endmodule
