module processor_tb1;
    // Define signals for the processor
    logic clk;
    logic reset;
    logic [255:0] debug_info;

    // Instantiate the processor top module
    processor_top1 processor_inst (
        .clk(clk),
        .reset(reset)
    );

    // Instantiate the debug monitor
    debug_monitor debug_monitor_inst (
        .clk(clk),
        .pc(processor_inst.pc_in),
        .instruction(processor_inst.instruction_out),
        .reg_file(processor_inst.reg_file),
        .debug_info(debug_info)
    );

    // Clock generation
    clock_generator clock_gen (
        .clk_out(clk)
    );

    // Apply reset
    initial begin
        reset = 1;
        #10 reset = 0; // Deassert reset after 10 time units
    end

    // Monitor debug information
    initial begin
        $monitor("Time: %t | PC: %h | Instruction: %h | Register 0: %h | Register 1: %h | Register 2: %h | Register 3: %h",
                 $time, processor_inst.pc_in, processor_inst.instruction_out, processor_inst.reg_file[0], 
                 processor_inst.reg_file[1], processor_inst.reg_file[2], processor_inst.reg_file[3]);
    end

    // Test sequence
    initial begin
        // Initialize the processor
        reset = 1;
        #10 reset = 0;

        // Apply some instructions (For example, load or arithmetic operations) and observe the debug output
        #100;  // Wait for some time (time unit based on the clock period)
        
        // Additional test cases could be added here by writing specific instructions to the memory and checking results

        #1000; // End of simulation
        $finish;
    end

endmodule
