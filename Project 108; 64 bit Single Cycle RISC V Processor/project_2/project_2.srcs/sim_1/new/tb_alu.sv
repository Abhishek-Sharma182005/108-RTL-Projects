module tb_alu;
    logic [63:0] a, b;                     // Inputs to the ALU
    logic [3:0] alu_ctrl;                  // ALU control signal
    logic [63:0] result;                   // Output from the ALU
    logic zero_flag;                       // Zero flag output

    alu uut (
        .i_a(a),
        .i_b(b),
        .i_alu_ctrl(alu_ctrl),
        .o_result(result),
        .o_zero(zero_flag)
    );

    initial begin
        // Test Addition
        a = 64'h0000000000000002; 
        b = 64'h0000000000000003;
        alu_ctrl = 4'b0000; 
        #10;
        
        assert(result == 64'h0000000000000005) else $fatal("Addition failed");

        // Test Subtraction
        a = 64'h0000000000000002; 
        b = 64'h0000000000000003;
        alu_ctrl = 4'b0001; 
        #10;

        // Check result for subtraction (should be -1 in two's complement)
        assert(result == 64'hFFFFFFFFFFFFFFFF) else $fatal("Subtraction failed");

        // Test AND operation
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'hAAAAAAAAAAAAAAAA;
        alu_ctrl = 4'b0010;
        #10;

        assert(result == 64'hAAAAAAAAAAAAAAAA) else $fatal("AND operation failed");

        // Test OR operation
        alu_ctrl = 4'b0011;
        #10;

        assert(result == 64'hFFFFFFFFFFFFFFFF) else $fatal("OR operation failed");

        // Test XOR operation
        alu_ctrl = 4'b0100;
        #10;

        assert(result == 64'h5555555555555555) else $fatal("XOR operation failed");

        // Test Shift Left operation
        a = 64'h1;
        alu_ctrl = 4'b0110;
        #10;

        assert(result == 64'h2) else $fatal("Shift Left failed");

        // Test Shift Right operation
        alu_ctrl = 4'b0111;
        #10;

        assert(result == 64'h0) else $fatal("Shift Right failed");

        $display("All tests passed!");
    end
endmodule
