`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 21:33:51
// Design Name: 
// Module Name: decoder_3to8
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


module decoder_3to8(
 input logic [2:0] in,
    output logic [7:0] out
    );
    always_comb begin
        out = 8'b00000000;
        case (in)
            3'b000: out[0] = 1;
            3'b001: out[1] = 1;
            3'b010: out[2] = 1;
            3'b011: out[3] = 1;
            3'b100: out[4] = 1;
            3'b101: out[5] = 1;
            3'b110: out[6] = 1;
            3'b111: out[7] = 1;
        endcase
    end
endmodule
