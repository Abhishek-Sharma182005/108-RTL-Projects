`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2024 19:42:17
// Design Name: 
// Module Name: BCLG_16bit
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


module BCLG_16bit (g, p, cin, cout, gout, pout);

  input [3:0] g, p;
  input cin;
  output [3:0] cout;
  output gout, pout;

  assign cout[0] = cin;
  assign cout[1] = g[0] | (p[0] & cin);
  assign cout[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
  assign cout[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);

  assign gout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
  assign pout = p[0] & p[1] & p[2] & p[3];
endmodule
