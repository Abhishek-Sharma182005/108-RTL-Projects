module forwarding_unit (
    input logic [4:0] rs1,          // Register 1 source
    input logic [4:0] rs2,          // Register 2 source
    input logic [4:0] rd_ex,        // Destination register from EX stage
    input logic [4:0] rd_mem,       // Destination register from MEM stage
    input logic reg_write_ex,       // Register write enable from EX stage
    input logic reg_write_mem,      // Register write enable from MEM stage
    output logic forward_a,         // Forwarding for operand A
    output logic forward_b          // Forwarding for operand B
);

    always_comb begin
        // Default no forwarding
        forward_a = 2'b00;
        forward_b = 2'b00;

        // Forwarding for Operand A
        if (reg_write_mem && (rs1 == rd_mem)) forward_a = 2'b10;  // Forward from MEM
        else if (reg_write_ex && (rs1 == rd_ex)) forward_a = 2'b01; // Forward from EX

        // Forwarding for Operand B
        if (reg_write_mem && (rs2 == rd_mem)) forward_b = 2'b10;  // Forward from MEM
        else if (reg_write_ex && (rs2 == rd_ex)) forward_b = 2'b01; // Forward from EX
    end
endmodule
