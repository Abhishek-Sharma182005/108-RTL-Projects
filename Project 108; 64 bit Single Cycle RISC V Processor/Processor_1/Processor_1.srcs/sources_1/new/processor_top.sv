module riscv_processor_top (
    input logic clk,
    input logic reset,
    output logic [63:0] debug_info // Debug information output
);

    // Internal signals for processor components
    logic [63:0] pc;
    logic [31:0] instruction;
    logic [6:0] opcode;
    logic [2:0] func3;
    logic [6:0] func7;
    logic [4:0] rs1, rs2, rd;
    logic [63:0] reg_data_a, reg_data_b;
    logic [63:0] alu_result;
    logic mem_read, mem_write;
    logic [63:0] mem_address, mem_data_in, mem_data_out;
    logic interrupt_request, interrupt_acknowledge;
    logic [63:0] pc_save;
    logic branch_taken, predicted_taken;
    logic [63:0] fpu_operand_a, fpu_operand_b, fpu_result;
    logic fpu_valid;
    
    // Pipeline signals
    logic [63:0] pc_if, pc_id, pc_ex, pc_mem, pc_wb;
    logic [31:0] instruction_if, instruction_id;
    logic [6:0] opcode_id;
    logic [2:0] func3_id;
    logic [6:0] func7_id;
    logic [4:0] rs1_id, rs2_id, rd_id;
    logic [63:0] reg_data_a_id, reg_data_b_id, alu_result_ex;
    logic [63:0] mem_data_out_mem;
    logic [63:0] write_data_wb;
    logic mem_to_reg_wb;
    logic reg_write_wb;

    // Instantiate the processor stages
    if_stage if_stage_inst (
        .clk(clk),
        .reset(reset),
        .pc_in(pc),
        .instruction_out(instruction_if),
        .pc_out(pc_if)
    );

    id_stage id_stage_inst (
        .clk(clk),
        .reset(reset),
        .instruction_in(instruction_if),
        .opcode(opcode_id),
        .func3(func3_id),
        .func7(func7_id),
        .rs1(rs1_id),
        .rs2(rs2_id),
        .rd(rd_id)
    );

    ex_stage ex_stage_inst (
        .clk(clk),
        .reset(reset),
        .a(reg_data_a_id),
        .b(reg_data_b_id),
        .alu_control(alu_control),
        .alu_result(alu_result_ex),
        .zero_flag(zero_flag)
    );

    mem_stage mem_stage_inst (
        .clk(clk),
        .reset(reset),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(mem_address),
        .write_data(mem_data_in),
        .read_data(mem_data_out_mem)
    );

    wb_stage wb_stage_inst (
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write_wb),
        .mem_to_reg(mem_to_reg_wb),
        .alu_result(alu_result_ex),
        .mem_data(mem_data_out_mem),
        .write_data(write_data_wb)
    );

    // Cache memory for data storage
    cache_memory cache_mem_inst (
        .clk(clk),
        .address(mem_address),
        .write_data(mem_data_in),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .read_data(mem_data_out)
    );

    // Clock generator module
    clock_generator clk_gen_inst (
        .clk_out(clk)
    );

    // Branch predictor module
    branch_predictor branch_predictor_inst (
    .clk(clk),
    .reset(reset),
    .branch_taken(branch_taken),
    .pc_in(pc_if),  // Use the correct signal here
    .predicted_taken(predicted_taken)
);


    // Floating point unit (FPU)
    fpu fpu_inst (
        .clk(clk),
        .operand_a(fpu_operand_a),
        .operand_b(fpu_operand_b),
        .result(fpu_result),
        .valid(fpu_valid)
    );

    // Interrupt controller
    interrupt_controller interrupt_controller_inst (
        .clk(clk),
        .reset(reset),
        .interrupt_request(interrupt_request),
        .interrupt_acknowledge(interrupt_acknowledge)
    );

    // I/O controller
    io_controller io_controller_inst (
        .clk(clk),
        .reset(reset),
        .io_read(io_read),
        .io_write(io_write),
        .io_ready(io_ready)
    );

    // I/O handler
    io_handler io_handler_inst (
        .clk(clk),
        .data_in(data_in),
        .data_out(data_out),
        .io_read(io_read),
        .io_write(io_write),
        .io_ready(io_ready)
    );

    // Control and Data path connections
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 64'b0; // Reset PC to 0
        end else begin
            pc <= pc_if; // Update PC with new value from IF stage
        end
    end

    // Debug monitor (Example: Combining PC and instruction for debugging purposes)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            debug_info <= 64'b0;
        end else begin
            debug_info <= {pc, instruction}; // Example: debug info with PC and instruction
        end
    end

endmodule
