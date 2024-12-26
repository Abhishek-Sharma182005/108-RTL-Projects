module tb_alu_64bit();

    // Testbench signals
    logic [63:0] a, b;
    logic [3:0] alu_ctrl;
    logic [63:0] result;
    logic zero;

    // Instantiate the ALU
    alu_64bit uut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );

    initial begin
        // Test Case 1: Addition
        a = 64'h00000000_00000010; // 2
        b = 64'h00000000_00000003; // 3
        alu_ctrl = 4'b0000;        // ADD
        #10;
        $display("ADD: Result = %h, Zero = %b", result, zero);

        // Test Case 2: Subtraction
        a = 64'h00000000_00000005; // 5
        b = 64'h00000000_00000005; // 5
        alu_ctrl = 4'b0001;        // SUB
        #10;
        $display("SUB: Result = %h, Zero = %b", result, zero);

        // Test Case 3: Logical AND
        a = 64'hF0F0F0F0_F0F0F0F0;
        b = 64'h0F0F0F0F_0F0F0F0F;
        alu_ctrl = 4'b0010;        // AND
        #10;
        $display("AND: Result = %h, Zero = %b", result, zero);

        // Test Case 4: Logical OR
        a = 64'hAAAAAAAA_AAAAAAAA;
        b = 64'h55555555_55555555;
        alu_ctrl = 4'b0011;        // OR
        #10;
        $display("OR: Result = %h, Zero = %b", result, zero);

        // Test Case 5: Shift Left Logical
        a = 64'h00000000_00000001; // 1
        b = 64'h00000000_00000010; // 2
        alu_ctrl = 4'b0101;        // SLL
        #10;
        $display("SLL: Result = %h, Zero = %b", result, zero);

        // Test Case 6: Arithmetic Right Shift
        a = 64'h80000000_00000000; // -2^31
        b = 64'h00000000_00000001; // 1
        alu_ctrl = 4'b0111;        // SRA
        #10;
        $display("SRA: Result = %h, Zero = %b", result, zero);

        // End simulation
        $stop;
    end
endmodule
