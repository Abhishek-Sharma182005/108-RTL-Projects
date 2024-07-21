`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2024 21:21:28
// Design Name: 
// Module Name: multiplexer_4to1_tb
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


module multiplexer_4to1_tb(

    ); logic [3:0] in;
    logic [1:0] sel;
    logic out;

    multiplexer_4to1 uut (
        .in(in),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Test vectors
        in = 4'b1010;
        sel = 2'b00;
        #10 sel = 2'b01;
        #10 sel = 2'b10;
        #10 sel = 2'b11;
        #10 $stop;
    end
endmodule
