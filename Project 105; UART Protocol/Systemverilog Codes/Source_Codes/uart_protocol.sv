`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.12.2024 23:21:48
// Design Name: 
// Module Name: uart_protocol
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


module uart_protocol1 #(
    parameter BAUD_RATE = 9600,
    parameter CLOCK_FREQ = 50000000
)(
    input wire clk,
    input wire rst,
    input wire [7:0] tx_data,   // Data to transmit
    input wire tx_start,        // Signal to start transmission
    input wire rx_serial,       // Serial input for receiver
    output wire tx_serial,      // Serial output for transmitter
    output wire [7:0] rx_data,  // Received data output
    output wire tx_done,        // Transmission done flag
    output wire rx_done         // Reception done flag
);

    // Internal signals
    wire baud_tick;

    // Instantiate baud generator
    baud_generator #(
        .BAUD_RATE(BAUD_RATE),
        .CLOCK_FREQ(CLOCK_FREQ)
    ) baud_gen_inst (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    // Instantiate UART transmitter
    uart_tx1 uart_tx_inst (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .data_in(tx_data),
        .send(tx_start),
        .tx_serial(tx_serial),
        .tx_done(tx_done)
    );

    // Instantiate UART receiver
    uart_rx1 uart_rx_inst (
        .clk(clk),
        .rst(rst),
        .rx_serial(rx_serial),
        .baud_tick(baud_tick),
        .data_out(rx_data),
        .rx_done(rx_done)
    );

endmodule
