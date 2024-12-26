
module tb_riscv_processor_top;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in time units

    // Signals for the processor
    logic clk;
    logic reset;
    logic [63:0] debug_info; // Debug output from the processor
    logic [63:0] pc_in; // Declare a register for PC input
    logic [31:0] instruction_out; // To capture instruction output from if_stage

    // Instantiate the RISC-V processor
    riscv_processor_top uut (
        .clk(clk),
        .reset(reset),
        .debug_info(debug_info)
    );

    // Clock generation
    always begin
        #(CLK_PERIOD / 2) clk = ~clk; // Toggle clock
    end

    // Initial block for stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1; // Assert reset
        pc_in = 64'b0; // Initialize PC input

        // Wait for some time and then release reset
        #(CLK_PERIOD * 2);
        reset = 0; // Deassert reset

        // Test case 1: Set PC value and observe instruction fetch at PC = 0
        pc_in = 64'b0; // Set initial PC value
     //   uut.if_stage_inst.pc_in = pc_in; // This line is incorrect and should be removed
        
        // Wait for a few clock cycles to observe behavior
        #(CLK_PERIOD * 5);
        
        // Display instruction output for verification
        $display("Instruction Output at PC=0: %h", uut.if_stage_inst.instruction_out);

        // Change PC value to test another instruction fetch
        pc_in = 64'b100; // Change register value for next instruction fetch
        
        #(CLK_PERIOD * 5);
        
        // Display instruction output for verification
        $display("Instruction Output at PC=4: %h", uut.if_stage_inst.instruction_out);

        // Finish simulation after a certain time
        #(CLK_PERIOD * 50);
        $finish;
    end

endmodule


