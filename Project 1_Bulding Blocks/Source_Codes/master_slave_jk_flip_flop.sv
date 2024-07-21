`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 11:27:44
// Design Name: 
// Module Name: master_slave_jk_flip_flop
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


module master_slave_jk_flip_flop(

    input logic J,
    input logic K,
    input logic clk,
    input logic reset,  // Optional: for synchronous reset
    output logic Q
);
    logic Q_master, Q_slave;

    // Master flip-flop
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            Q_master <= 0;  // Reset master Q to 0
        else if (J && ~K)
            Q_master <= 1;  // Set
        else if (~J && K)
            Q_master <= 0;  // Reset
        else if (J && K)
            Q_master <= ~Q_master;  // Toggle
    end

    // Slave flip-flop
    always_ff @(negedge clk or posedge reset) begin
        if (reset)
            Q_slave <= 0;  // Reset slave Q to 0
        else
            Q_slave <= Q_master;  // Capture output from master
    end

    assign Q = Q_slave;
endmodule
