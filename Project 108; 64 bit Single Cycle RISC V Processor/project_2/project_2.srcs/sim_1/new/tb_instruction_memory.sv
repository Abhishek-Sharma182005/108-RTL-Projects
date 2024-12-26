module tb_instruction_memory;
    logic [63:0] address;               // Input address for fetching instructions
    logic [31:0] instruction;            // Output instruction
    logic clk;                           // Clock signal

    // Instantiate the instruction memory
    instruction_memory uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin
        // Initialize clock
        clk = 0;
        forever #5 clk = ~clk; // Generate a clock with a period of 10 time units
    end

    initial begin
        // Test fetching instructions from memory
        // Test for valid addresses (adjusting to word-aligned addresses)
        for (int i = 0; i < 39; i++) begin
            address = {32'h0, i << 2}; // Set address (lower 32 bits) to fetch instructions (shift left by 2 for word alignment)
            #10;                 // Wait for clock edge
            
            // Display fetched instruction
            $display("Address: %0h, Instruction: %h", address, instruction);
            
            // Check if the fetched instruction matches the expected value
            case (i)
                0: assert(instruction == 32'h00000033) else $fatal("Mismatch at address %0h", address);
                1: assert(instruction == 32'h00108093) else $fatal("Mismatch at address %0h", address);
                2: assert(instruction == 32'h00208113) else $fatal("Mismatch at address %0h", address);
                3: assert(instruction == 32'h002081b3) else $fatal("Mismatch at address %0h", address);
                4: assert(instruction == 32'h00308093) else $fatal("Mismatch at address %0h", address);
                5: assert(instruction == 32'h00408113) else $fatal("Mismatch at address %0h", address);
                6: assert(instruction == 32'h005081b3) else $fatal("Mismatch at address %0h", address);
                7: assert(instruction == 32'h00608233) else $fatal("Mismatch at address %0h", address);
                8: assert(instruction == 32'h00f30313) else $fatal("Mismatch at address %0h", address);
                9: assert(instruction == 32'h00c303b3) else $fatal("Mismatch at address %0h", address);
                // Continue with other expected values as needed...
                default: assert(instruction == 32'h00000033) else $fatal("Expected NOP at address %0h", address); // For NOPs
            endcase
        end
        
        // Test out-of-bounds access
        for (int i = 1024; i < 1100; i++) begin
            address = {32'h0, i << 2}; // Set out-of-bounds addresses (shift left by 2 for word alignment)
            #10;                 // Wait for clock edge
            
            // Display fetched instruction
            $display("Out-of-Bounds Address: %0h, Instruction: %h", address, instruction);
            assert(instruction == 32'h00000033) else $fatal("Expected NOP for out-of-bounds access at %0h", address);
        end
        
        $display("All tests passed!");
        $finish;
    end
endmodule
