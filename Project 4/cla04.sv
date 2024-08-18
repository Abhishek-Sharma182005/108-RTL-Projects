`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2024 19:40:48
// Design Name: 
// Module Name: cla04
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



module cla04 (
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic       Cin,
    output logic [3:0] Sum,
  //  output logic       Cout,
    output logic       gout, // Propagate
    output logic       pout  // Generate
);

    logic [3:0] G_i, P_i,Ci;

    assign G_i = A & B;  // Generate
    assign P_i = A ^ B;  // Propagate

   // assign C_i[0] = Cin;
   // assign C_i[1] = G_i[0] | (P_i[0] & Cin);
  //  assign C_i[2] = G_i[1] | (P_i[1] & C_i[1]);
   // assign C_i[3] = G_i[2] | (P_i[2] & C_i[2]);
   // assign Cout = G_i[3] | (P_i[3] & C_i[3]);
BCLG_16bit  a1(G_i, P_i, Cin, Ci, gout, pout);
    assign Sum = P_i ^ Ci;
  //  assign Cout=Ci[3];

  //  assign P = &P_i; // Overall block propagate
   // assign G = G_i[3] | (P_i[3] & G_i[2]) | (P_i[3] & P_i[2] & G_i[1]) | (P_i[3] & P_i[2] & P_i[1] & G_i[0]); // Overall block generate

endmodule
