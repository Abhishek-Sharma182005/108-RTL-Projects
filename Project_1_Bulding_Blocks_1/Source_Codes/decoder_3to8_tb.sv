`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 21:34:38
// Design Name: 
// Module Name: decoder_3to8_tb
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


module decoder_3to8_tb(

    );
    logic [2:0] in;
    logic [7:0] out;

    decoder_3to8 uut (
        .in(in),
        .out(out)
    );

    initial begin
        // Test vectors
        in = 3'b000;
        #10 in = 3'b001;
        #10 in = 3'b010;
        #10 in = 3'b011;
        #10 in = 3'b100;
        #10 in = 3'b101;
        #10 in = 3'b110;
        #10 in = 3'b111;
        #10 $stop;
    end
endmodule
