module project8_tb;

    logic [15:0] A, B;
    logic        Cin;
    logic [15:0] Sum;
    logic        Cout;

    // Instantiate the Kogge-Stone Adder
    project8 uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    // Test cases
    initial begin
        // Initialize inputs
        A = 16'h0000; B = 16'h0000; Cin = 1'b0;
        #10;  // Wait for 10 time units

        // Test case 1
        A = 16'h1234; B = 16'h5678; Cin = 1'b0;
        #10;
        $display("A=%h, B=%h, Cin=%b -> Sum=%h, Cout=%b", A, B, Cin, Sum, Cout);

        // Test case 2
        A = 16'hAAAA; B = 16'h5555; Cin = 1'b1;
        #10;
        $display("A=%h, B=%h, Cin=%b -> Sum=%h, Cout=%b", A, B, Cin, Sum, Cout);

        // Test case 3
        A = 16'hFFFF; B = 16'h0001; Cin = 1'b0;
        #10;
        $display("A=%h, B=%h, Cin=%b -> Sum=%h, Cout=%b", A, B, Cin, Sum, Cout);

        // Test case 4
        A = 16'hFFFF; B = 16'hFFFF; Cin = 1'b1;
        #10;
        $display("A=%h, B=%h, Cin=%b -> Sum=%h, Cout=%b", A, B, Cin, Sum, Cout);

        // Test case 5
        A = 16'h8000; B = 16'h8000; Cin = 1'b0;
        #10;
        $display("A=%h, B=%h, Cin=%b -> Sum=%h, Cout=%b", A, B, Cin, Sum, Cout);

        $finish; // End simulation
    end

endmodule
