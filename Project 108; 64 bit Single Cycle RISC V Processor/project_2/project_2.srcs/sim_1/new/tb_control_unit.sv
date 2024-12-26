`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2024 01:34:26
// Design Name: 
// Module Name: tb_control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_control_unit;


    // Clock signal
    logic clk;

    // Signals for Instruction Memory
    logic [63:0] instruction_address;
    logic [31:0] instruction;

    // Signals for Instruction Decode
    logic [6:0] opcode;
    logic [2:0] func3;
    logic [6:0] func7;

    // Signals for Control Unit
    logic [3:0] alu_control;
    logic reg_write;
    logic mem_read;
    logic mem_write;
    logic branch;
    logic mem_to_reg;
    logic alu_src;

    // Signals for ALU
    logic [63:0] alu_input_a; // First ALU input (from register file)
    logic [63:0] alu_input_b; // Second ALU input (from immediate or register)
    logic [63:0] alu_result;   // ALU output

    // Signals for Data Memory
    logic [63:0] data_memory_address; // Address for data memory
    logic [63:0] write_data;          // Data to write to memory
    logic [63:0] read_data;           // Data read from memory

    // Instantiate the Instruction Memory
    instruction_memory imem (
        .address(instruction_address),
        .instruction(instruction)
    );

    // Instantiate the Instruction Decode Module
    instruction_decode id (
        .instruction(instruction),
        .opcode(opcode),
        .func3(func3),
        .func7(func7)
    );

    // Instantiate the Control Unit
    control_unit cu (
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .alu_control(alu_control),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src)
    );

    // Instantiate the ALU
    alu my_alu (
        .i_a(alu_input_a),
        .i_b(alu_input_b),
        .i_alu_ctrl(alu_control),
        .o_result(alu_result)
    );

    // Instantiate the Data Memory
    data_memory dmem (
        .clk(clk), 
        .address(data_memory_address), 
        .write_data(write_data), 
        .mem_write(mem_write), 
        .mem_read(mem_read), 
        .read_data(read_data)
    );

    initial begin
        // Initialize clock
        clk = 0;
        forever #5 clk = ~clk; // Generate a clock with a period of 10 time units
    end

    initial begin
        // Test Case 1: Load Word (LW) and Store Word (SW)

        // Load instruction for LW x1, 0(x2) (Assuming address calculation is done)
        
        instruction_address = 64'h00000000; 
        #10;  // Wait for instruction fetch
        
        instruction = 32'h00000003;  // LW x1, 0(x2) - Example encoding
        
        // Decode the instruction
        #10;

        // Set up inputs for ALU based on decoded instruction (for simplicity)
        
        alu_input_a = 64'h0000000000000002; // Assume x2 contains address 2
        alu_input_b = 64'h00000000;         // Immediate is zero in this case
        
        #10;  // Wait for ALU operation
        
        data_memory_address = alu_input_a + alu_input_b;   // Set address to ALU result
        
        mem_read = 1;                       // Enable read from memory
        #10;                                 

        expected_value = 64'hDEADBEEFCAFEBABE;  // Expected value to be read from memory
        
        assert(read_data == expected_value) else $fatal("LW Test Failed");

        
       // Store instruction for SW x1, 0(x2) (Assuming address calculation is done)
       instruction_address = 64'h00000004; 
       #10; 

       instruction = 32'h00000023;  // SW x1, 0(x2) - Example encoding

       #10;

       write_data = alu_result;      // Data to write from ALU result
       mem_write = 1;                // Enable write to memory
       
       #10;

       mem_write = 0;                // Disable write after operation

       $display("All tests passed!");
       $finish;
   end

endmodule

