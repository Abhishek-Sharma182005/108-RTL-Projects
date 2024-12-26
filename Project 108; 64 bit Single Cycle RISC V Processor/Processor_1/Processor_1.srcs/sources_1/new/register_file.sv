module register_file (
    input logic clk,                  // Clock signal
    input logic reset,                // Reset signal
    input logic [4:0] rs1,            // Source register 1
    input logic [4:0] rs2,            // Source register 2
    input logic [4:0] rd,             // Destination register
    input logic [63:0] write_data,    // Data to write
    input logic reg_write,            // Register write enable
    output logic [63:0] rs1_data,     // Data read from rs1
    output logic [63:0] rs2_data      // Data read from rs2
);

    // 32 registers, each 64 bits wide
    logic [63:0] registers [31:0];

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize all registers to 0 on reset
            registers[0] <= 64'b0;
            registers[1] <= 64'b0;
            registers[2] <= 64'b0;
            registers[3] <= 64'b0;
            // Add the rest of the registers initialization here...
        end else if (reg_write) begin
            registers[rd] <= write_data;  // Write data to destination register
        end
    end

    // Read data from rs1 and rs2 registers
    assign rs1_data = registers[rs1];
    assign rs2_data = registers[rs2];

endmodule
