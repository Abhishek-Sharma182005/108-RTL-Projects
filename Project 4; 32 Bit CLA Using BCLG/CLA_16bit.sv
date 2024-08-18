`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2024 19:46:46
// Design Name: 
// Module Name: CLA_16bit
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


module CLA_16bit (
    input  logic [15:0] A,
    input  logic [15:0] B,
    input  logic        Cin,
    output logic [15:0] Sum,
    output logic       Cout,
    output logic gout,pout
);

    logic [3:0] P, G, C;
    logic [15:0] Sum0 ;

    cla04 cla0 (A[ 3: 0], B[ 3: 0], Cin, Sum0[3:0], G[0], P[0]);
    cla04 cla1 (A[ 7: 4], B[ 7: 4], C[1], Sum0[7:4], G[1], P[1]);
    cla04 cla2 (A[11: 8], B[11: 8], C[2], Sum0[11:8], G[2], P[2]);
    cla04 cla3 (A[15:12], B[15:12], C[3], Sum0[15:12], G[3], P[3]);

    BCLG_16bit bclg (G, P, Cin, C,gout,pout);

    assign Sum = {Sum0[15:12], Sum0[11:8], Sum0[7:4], Sum0[3:0]};
   assign Cout = C[3];

endmodule
