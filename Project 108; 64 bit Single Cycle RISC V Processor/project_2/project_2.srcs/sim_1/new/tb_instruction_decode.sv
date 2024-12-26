module tb_instruction_decode;
    logic [31:0] instruction;            // 32-bit instruction input
    logic [6:0] opcode;                  // Output opcode (7 bits)
    logic [4:0] rs1;                     // Output source register 1 (5 bits)
    logic [4:0] rs2;                     // Output source register 2 (5 bits)
    logic [4:0] rd;                      // Output destination register (5 bits)
    logic [2:0] func3;                   // Output function code 3 (3 bits)
    logic [6:0] func7;                   // Output function code 7 (7 bits)

    // Instantiate the instruction decoder
    instruction_decode uut (
        .instruction(instruction),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .func3(func3),
        .func7(func7)
    );

    initial begin
        // Test cases for various instructions
        // Example instructions (opcode, rs1, rs2, rd, func3, func7)

        // Test 1: ADD x0, x0, x0 (NOP)
        instruction = 32'h00000033; // Opcode: 0110011
        #10;
        assert(opcode == 7'b0110011) else $fatal("Test 1 Failed: Expected opcode 0110011, got %b", opcode);
        assert(rs1 == 5'b00000) else $fatal("Test 1 Failed: Expected rs1 00000, got %b", rs1);
        assert(rs2 == 5'b00000) else $fatal("Test 1 Failed: Expected rs2 00000, got %b", rs2);
        assert(rd == 5'b00000) else $fatal("Test 1 Failed: Expected rd 00000, got %b", rd);
        assert(func3 == 3'b000) else $fatal("Test 1 Failed: Expected func3 000, got %b", func3);
        assert(func7 == 7'b0000000) else $fatal("Test 1 Failed: Expected func7 0000000, got %b", func7);

        // Test 2: ADDI x1, x1, 1
        instruction = 32'h00108093; // Opcode: 0010011
        #10;
        assert(opcode == 7'b0010011) else $fatal("Test 2 Failed: Expected opcode 0010011, got %b", opcode);
        assert(rs1 == 5'b00001) else $fatal("Test 2 Failed: Expected rs1 00001, got %b", rs1);
        assert(rs2 == 5'b00000) else $fatal("Test 2 Failed: Expected rs2 00000, got %b", rs2);
        assert(rd == 5'b00001) else $fatal("Test 2 Failed: Expected rd 00001, got %b", rd);
        assert(func3 == 3'b000) else $fatal("Test 2 Failed: Expected func3 000, got %b", func3);
        assert(func7 == 7'b0000000) else $fatal("Test 2 Failed: Expected func7 0000000, got %b", func7);

        // Test 3: SUB x7, x6, x12
        instruction = 32'h00c303b3; // Opcode: 0110011
        #10;
        assert(opcode == 7'b0110011) else $fatal("Test 3 Failed: Expected opcode 0110011, got %b", opcode);
        assert(rs1 == 5'b00110) else $fatal("Test 3 Failed: Expected rs1 00110, got %b", rs1);
        assert(rs2 == 5'b01100) else $fatal("Test 3 Failed: Expected rs2 01100, got %b", rs2);
        assert(rd == 5'b00111) else $fatal("Test 3 Failed: Expected rd 00111, got %b", rd);
        assert(func3 == 3'b000) else $fatal("Test 3 Failed: Expected func3 000, got %b", func3);
        assert(func7 == 7'b0100000) else $fatal("Test 3 Failed: Expected func7 0100000, got %b", func7);

        // Additional tests can be added here...

        $display("All tests passed!");
        $finish;
    end
endmodule
