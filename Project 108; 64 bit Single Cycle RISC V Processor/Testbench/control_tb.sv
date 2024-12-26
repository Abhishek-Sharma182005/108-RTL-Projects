module control_tb;
    // Declare the inputs to the control unit
    reg [6:0] opcode;
    reg [2:0] func3;
    reg [6:0] func7;
    
    // Declare the outputs from the control unit
    wire [3:0] alu_control;
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire branch;
    wire mem_to_reg;
    wire alu_src;
    
    // Instantiate the control unit module
    control_unit uut (
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
    
    // Test procedure
    initial begin
        // Initialize the signals
        $display("Starting Testbench...");
        
        // Test R-type instruction (ADD)
        opcode = 7'b0110011; // R-type
        func3 = 3'b000; // ADD
        func7 = 7'b0000000; // ADD
        #10; // Wait for 10 time units
        $display("R-type ADD - ALU Control: %b, RegWrite: %b, MemRead: %b, MemWrite: %b, Branch: %b, MemToReg: %b, ALUSrc: %b", 
                 alu_control, reg_write, mem_read, mem_write, branch, mem_to_reg, alu_src);
        
        // Test I-type instruction (ADDI)
        opcode = 7'b0010011; // I-type
        func3 = 3'b000; // ADDI
        func7 = 7'b0000000; // No specific func7 for ADDI
        #10; // Wait for 10 time units
        $display("I-type ADDI - ALU Control: %b, RegWrite: %b, MemRead: %b, MemWrite: %b, Branch: %b, MemToReg: %b, ALUSrc: %b", 
                 alu_control, reg_write, mem_read, mem_write, branch, mem_to_reg, alu_src);
        
        // Test Load instruction (LW)
        opcode = 7'b0000011; // Load
        func3 = 3'b010; // LW
        func7 = 7'b0000000; // No specific func7 for LW
        #10; // Wait for 10 time units
        $display("Load LW - ALU Control: %b, RegWrite: %b, MemRead: %b, MemWrite: %b, Branch: %b, MemToReg: %b, ALUSrc: %b", 
                 alu_control, reg_write, mem_read, mem_write, branch, mem_to_reg, alu_src);
        
        // Test Store instruction (SW)
        opcode = 7'b0100011; // Store
        func3 = 3'b010; // SW
        func7 = 7'b0000000; // No specific func7 for SW
        #10; // Wait for 10 time units
        $display("Store SW - ALU Control: %b, RegWrite: %b, MemRead: %b, MemWrite: %b, Branch: %b, MemToReg: %b, ALUSrc: %b", 
                 alu_control, reg_write, mem_read, mem_write, branch, mem_to_reg, alu_src);
        
        // End of test
        $display("Testbench Completed.");
        $finish;
    end
endmodule
