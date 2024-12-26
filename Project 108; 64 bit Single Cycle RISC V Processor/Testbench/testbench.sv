module tb_instruction_memory;
    logic [63:0] address;       // Address input to the instruction memory
    logic [31:0] instruction;    // Output instruction from the memory

    // Instantiate the instruction memory module
    instruction_memory imem_inst (
        .address(address),
        .instruction(instruction)
    );

    initial begin
        // Test valid addresses for initialized instructions
        address = 64'h0;          // Address 0 (NOP)
        #10; 
        assert(instruction == 32'h00000033) else $fatal("Error: Expected NOP at address %h", address);

        address = 64'h4;          // Address 4 (ADDI x1, x1, 1)
        #10; 
        assert(instruction == 32'h00108093) else $fatal("Error: Expected ADDI x1, x1, 1 at address %h", address);

        address = 64'h8;          // Address 8 (ADDI x2, x2, 2)
        #10; 
        assert(instruction == 32'h00208113) else $fatal("Error: Expected ADDI x2, x2, 2 at address %h", address);

        address = 64'hC;          // Address 12 (ADD x3, x2, x2)
        #10; 
        assert(instruction == 32'h002081b3) else $fatal("Error: Expected ADD x3, x2, x2 at address %h", address);

        address = 64'h10;         // Address 16 (ADDI x4, x4, 3)
        #10; 
        assert(instruction == 32'h00308093) else $fatal("Error: Expected ADDI x4, x4, 3 at address %h", address);

        address = 64'h14;         // Address 20 (ADDI x5, x5, 4)
        #10; 
        assert(instruction == 32'h00408113) else $fatal("Error: Expected ADDI x5, x5, 4 at address %h", address);

        address = 64'h18;         // Address 24 (ADD x6, x5, x5)
        #10; 
        assert(instruction == 32'h005081b3) else $fatal("Error: Expected ADD x6, x5, x5 at address %h", address);

        address = 64'h1C;         // Address 28 (ADD x7, x3, x4)
        #10; 
        assert(instruction == 32'h00608233) else $fatal("Error: Expected ADD x7, x3, x4 at address %h", address);

        // Test out-of-bounds addresses
        address = 64'hFA0;       // Out of bounds address
        #10; 
        assert(instruction == 32'h00000033) else $fatal("Error: Expected NOP for out-of-bounds access");

        address = 64'h2710;      // Another out of bounds address
        #10; 
        assert(instruction == 32'h00000033) else $fatal("Error: Expected NOP for out-of-bounds access");

         // Additional tests for custom instructions
         address = 64'h58;       // Corrected Address for AESENC (22 * sizeof(32-bit))
         #10;
         assert(instruction == 32'hA001A001) else $fatal("Error: Expected AESENC at address %h", address);

         address = 64'h6C;       // Corrected Address for VDOT (27 * sizeof(32-bit))
         #10;
         assert(instruction == 32'hB001B001) else $fatal("Error: Expected VDOT at address %h", address);

         $display("All tests passed!");
         $finish;
     end

     initial begin 
         $monitor("Time: %0t | Address: %h | Instruction: %h", $time, address, instruction); 
     end 

endmodule
