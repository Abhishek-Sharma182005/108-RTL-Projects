`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.12.2024 14:03:22
// Design Name: 
// Module Name: baud_generator
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


module baud_generator #(parameter BAUD_RATE = 9600, CLOCK_FREQ = 50000000)(
    input wire clk,
    input wire rst,
    output reg baud_tick
);

    localparam TICKS = CLOCK_FREQ / BAUD_RATE;
    reg [15:0] tick_counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tick_counter <= 0;
            baud_tick <= 0;
        end else begin
            if (tick_counter == TICKS - 1) begin
                tick_counter <= 0;
                baud_tick <= 1;
            end else begin
                tick_counter <= tick_counter + 1;
                baud_tick <= 0;
            end
        end
    end
endmodule