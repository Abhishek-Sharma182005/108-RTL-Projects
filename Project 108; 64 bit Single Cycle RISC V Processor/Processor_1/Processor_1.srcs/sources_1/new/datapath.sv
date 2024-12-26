module datapath (
    input logic clk,
    input logic reset
);
    // PC and instruction memory
    logic [63:0] pc_in, pc_out;
    logic [31:0] instruction;

    program_counter pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Instruction memory instantiation
    instruction_memory imem_inst (
        .address(pc_out),      // Address input to instruction memory
        .instruction(instruction) // Output instruction
    );
    
    // Instruction decode
    logic [6:0] opcode;
    logic [4:0] rs1, rs2, rd;
    logic [2:0] func3;
    logic [6:0] func7;

    instruction_decode id_inst (
        .instruction(instruction),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .func3(func3),
        .func7(func7)
    );

    // Control Unit
    logic [3:0] alu_control;
    logic reg_write, mem_read, mem_write, branch, mem_to_reg, alu_src;

    control_unit cu_inst (
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

    // Register File
    logic [63:0] read_data1, read_data2, write_data;
    
    register_file_64bit rf_inst (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),                
        .rs2(rs2),                
        .rd(rd),                   
        .write_data(write_data),  
        .reg_write(reg_write),    
        .read_data1(read_data1),  
        .read_data2(read_data2)   
    );

    // ALU
    logic [63:0] alu_result;
    logic alu_zero;

    alu_64bit alu_inst (
        .a(read_data1),
        .b(alu_src ? {{56{instruction[31]}}, instruction[31:20]} : read_data2), // ALU source handling
        .alu_ctrl(alu_control),
        .result(alu_result),
        .zero(alu_zero)
    );

    // Memory (for load/store)
    logic [63:0] memory_data;
    logic [63:0] mem_address;
    
    data_memory mem_inst (
        .address(mem_address),
        .write_data(read_data2),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .read_data(memory_data)
    );

    // Write-back (selecting between ALU result and memory)
    assign write_data = mem_to_reg ? memory_data : alu_result;

    // Branch logic and PC update
    assign pc_in = (branch && alu_zero) ? (pc_out + {{52{instruction[31]}}, instruction[31:25], instruction[11:7]}) : (pc_out + 4); // Branch handling

endmodule
