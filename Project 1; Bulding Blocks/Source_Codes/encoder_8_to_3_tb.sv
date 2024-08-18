`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 11:44:24
// Design Name: 
// Module Name: encoder_8_to_3_tb
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


module encoder_8_to_3_tb(

    ); logic [7:0] in;
    logic [2:0] out;

    encoder_8_to_3 uut (
        .in(in),
        .out(out)
    );

    initial begin
        // Test all possible inputs
        in = 8'b00000001; #10;
        $display("Input: %b, Output: %b", in, out);

        in = 8'b00000010; #10;
        $display("Input: %b, Output: %b", in, out);

        in = 8'b00000100; #10;
        $display("Input: %b, Output: %b", in, out);

        in = 8'b00001000; #10;
        $display("Input: %b, Output: %b", in, out);

        in = 8'b00010000; #10;
        $display("Input: %b, Output: %b", in, out);

        in = 8'b00100000; #10;
        $display("Input: %b, Output: %b", in, out);

        in = 8'b01000000; #10;
        $display("Input: %b, Output: %b", in, out);

        in = 8'b10000000; #10;
        $display("Input: %b, Output: %b", in, out);

        $stop;
    end
endmodule
