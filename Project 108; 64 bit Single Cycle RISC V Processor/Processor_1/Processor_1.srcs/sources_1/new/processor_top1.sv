module processor_top1 (
    input logic clk,
    input logic reset
);
    // Internal signals for IF, ID, EX, MEM, WB stages and control
    logic [63:0] pc_in, pc_out;
    logic [31:0] instruction_out;
    logic [63:0] alu_result, write_data, read_data;
    logic [6:0] opcode;
    logic [2:0] func3;
    logic [6:0] func7;
    logic [4:0] rs1, rs2, rd;
    logic zero_flag, reg_write, mem_read, mem_write, branch, mem_to_reg, alu_src;
    logic [3:0] alu_control;

    // Internal signals for control and memory
    logic [63:0] a, b;
    logic [63:0] address;
    
    // Instantiate the pipeline stages

    // IF Stage
    if_stage if_stage_inst (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .instruction_out(instruction_out),
        .pc_out(pc_out)
    );

    // ID Stage
    id_stage id_stage_inst (
        .clk(clk),
        .reset(reset),
        .instruction_in(instruction_out),
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd)
    );

    // EX Stage
    ex_stage ex_stage_inst (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .zero_flag(zero_flag)
    );

    // MEM Stage
    mem_stage mem_stage_inst (
        .clk(clk),
        .reset(reset),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // WB Stage
    wb_stage wb_stage_inst (
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .mem_to_reg(mem_to_reg),
        .alu_result(alu_result),
        .mem_data(read_data),
        .write_data(write_data)
    );

    // Instantiate Control Unit
    control_unit control_unit_inst (
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

 // Register file instantiation
    register_file reg_file_inst (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .reg_write(reg_write),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Program Counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_in <= 64'b0; // Reset PC to 0
        end else begin
            if (branch) begin
                pc_in <= pc_out + 4; // For branches, adjust PC as needed
            end else begin
                pc_in <= pc_out;
            end
        end
    end
    
    // Increment PC for the next instruction
    assign pc_out = pc_in + 4;

endmodule
