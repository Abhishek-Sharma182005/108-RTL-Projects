module tb_datapath;

    // Testbench signals
    logic clk;
    logic reset;

    // Instantiate the datapath
    datapath dp_inst (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 100 MHz clock (10ns period)
    end

    // Stimulus generation
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Apply reset
        #10 reset = 0;

        // Wait for some time to simulate processing
        #1000;

        // Display values after 1000ns
        $display("Time: %0t | PC: %h | Instruction: %h | ALU Result: %h", 
            $time, dp_inst.pc_out, dp_inst.instruction, dp_inst.alu_result);

        // Finish simulation after 1000ns
        $finish;
    end

endmodule
