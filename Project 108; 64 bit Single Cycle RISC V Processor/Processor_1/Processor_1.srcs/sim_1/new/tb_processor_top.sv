module tb_processor_top;
    reg clk;
    reg reset;
    wire [63:0] pc_out;
    wire [63:0] alu_result;
    wire [31:0] instruction;

    // Instantiate the processor_top module
    processor_top uut (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .alu_result(alu_result),
        .instruction(instruction)  // Now connects to the 'instruction' output
    );

    // Clock Generation
    always begin
        #5 clk = ~clk; // 100 MHz clock (10ns period)
    end

    // Stimulus Generation
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1; // Apply reset initially
        #20 reset = 0; // Deassert reset after 20ns
        
        // Monitor the signals during the simulation
        $monitor("Time: %0t | clk: %b | reset: %b | instruction: %h | pc_out: %h | alu_result: %h", 
                 $time, clk, reset, instruction, pc_out, alu_result);

        // Apply test cases and observe outputs

        // Test 1: Apply reset for some time and check if the processor is idle
        #20; // 20ns of reset
        $display("After Reset: PC = %h, Instruction = %h", pc_out, instruction);

        // Test 2: Let the processor run for a few cycles
        #100; // Run for 100ns (10 clock cycles)
        $display("After 100ns: PC = %h, Instruction = %h, ALU Result = %h", pc_out, instruction, alu_result);

        // Test 3: Run for additional time to simulate processing
        #500; // Run for another 500ns (50 clock cycles)
        $display("After 600ns: PC = %h, Instruction = %h, ALU Result = %h", pc_out, instruction, alu_result);

        // Finish the simulation
        $finish;
    end
endmodule
