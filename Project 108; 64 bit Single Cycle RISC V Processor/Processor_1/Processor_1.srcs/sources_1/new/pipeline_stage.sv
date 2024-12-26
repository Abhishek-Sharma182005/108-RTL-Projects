module if_stage (
    input logic clk,
    input logic reset,
    input logic [63:0] pc_in,
    output logic [31:0] instruction_out,
    output logic [63:0] pc_out
);
    logic [63:0] pc; // Internal PC register

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 64'b0; // Reset PC to 0
        end else begin
            pc <= pc_in; // Update PC with input
        end
    end

    instruction_memory imem (
        .address(pc[11:2]),  // Use only the lower 10 bits of the PC address
        .instruction(instruction_out) // Fetch instruction based on the PC address
    );

    assign pc_out = pc + 4; // Increment PC for next instruction
endmodule


module id_stage (
    input logic clk,
    input logic reset,
    input logic [31:0] instruction_in,
    output logic [6:0] opcode,
    output logic [2:0] func3,
    output logic [6:0] func7,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd
);
    instruction_decode id (
        .instruction(instruction_in),
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd)
    );
endmodule
module ex_stage (
    input logic clk,
    input logic reset,
    input logic [63:0] a, // Operand A from register file
    input logic [63:0] b, // Operand B from register file or immediate value
    input logic [3:0] alu_control,
    output logic [63:0] alu_result,
    output logic zero_flag
);
    alu_64bit alu (
        .a(a),
        .b(b),
        .alu_ctrl(alu_control),
        .result(alu_result),
        .zero(zero_flag)
    );
endmodule
module mem_stage (
    input logic clk,
    input logic reset,
    input logic mem_read,
    input logic mem_write,
    input logic [63:0] address, // Address to read/write data
    input logic [63:0] write_data, // Data to write (for store)
    output logic [63:0] read_data // Data read from memory
);
   data_memory mem (
       .clk(clk),
       .address(address),
       .write_data(write_data),
       .mem_read(mem_read),
       .mem_write(mem_write),
       .read_data(read_data)
   );
endmodule
module wb_stage (
    input logic clk,
    input logic reset,
    input logic reg_write,
    input logic mem_to_reg,
    input logic [63:0] alu_result,
    input logic [63:0] mem_data, // Data read from memory
    output logic [63:0] write_data // Data to write back to register file
);
   always_ff @(posedge clk or posedge reset) begin
       if (reset) begin
           write_data <= 64'b0; 
       end else begin 
           if (mem_to_reg) 
               write_data <= mem_data; // Read data from memory if required 
           else 
               write_data <= alu_result; // Otherwise, use ALU result 
       end 
   end 
endmodule 
