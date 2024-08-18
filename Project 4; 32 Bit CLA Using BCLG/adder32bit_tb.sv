`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2024 13:30:38
// Design Name: 
// Module Name: adder32bit_tb
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


module adder32bit_tb(

    );
   

    // Declare inputs as reg and outputs as wire
    logic [31:0] A;
    logic [31:0] B;
    logic Cin;
   logic [31:0] Sum;
    logic Cout;

    // Instantiate the bclg32 module
    bclg32 uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    // Testbench procedure
    initial begin
        // Initialize inputs
        A = 32'h00000000;
        B = 32'h00000000;
        Cin = 1'b0;
        #10;  // Wait for 10 time units
        
        // Test Case 1: Add zero to zero
        A = 32'h00000000;
        B = 32'h00000000;
        Cin = 1'b0;
        #10;
        $display("TC1: A = %h, B = %h, Cin = %b | Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);
        
        // Test Case 2: Add two small numbers
        A = 32'h0000000F;
        B = 32'h00000001;
        Cin = 1'b0;
        #10;
        $display("TC2: A = %h, B = %h, Cin = %b | Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);
        
        // Test Case 3: Add two large numbers with carry in
        A = 32'hFFFFFFFF;
        B = 32'h00000001;
        Cin = 1'b1;
        #10;
        $display("TC3: A = %h, B = %h, Cin = %b | Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);
        
        // Test Case 4: Add large and small number with carry in
        A = 32'h12345678;
        B = 32'h87654321;
        Cin = 1'b1;
        #10;
        $display("TC4: A = %h, B = %h, Cin = %b | Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);
        
        // Test Case 5: Add random values
        A = 32'hABCDEF01;
        B = 32'h12345678;
        Cin = 1'b0;
        #10;
        $display("TC5: A = %h, B = %h, Cin = %b | Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);
        
        // Test Case 6: Overflow check
        A = 32'h80000000;
        B = 32'h80000000;
        Cin = 1'b0;
        #10;
        $display("TC6: A = %h, B = %h, Cin = %b | Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);
        
        // Finish simulation
        $finish;
    end



endmodule
