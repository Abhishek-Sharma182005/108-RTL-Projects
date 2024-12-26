module register_file_64bit (
    input logic clk,
    input logic reset,
    input logic [4:0] rs1,        // Source register 1 address
    input logic [4:0] rs2,        // Source register 2 address
    input logic [4:0] rd,         // Destination register address
    input logic [63:0] write_data, // 64-bit data to be written
    input logic reg_write,        // Write enable signal
    output logic [63:0] read_data1, // Output from rs1
    output logic [63:0] read_data2  // Output from rs2
);

    // Number of registers and width
    parameter NUM_REGISTERS = 32;
    parameter REG_WIDTH = 64;

    // Register array: 32 Registers, each 64 bits wide
    logic [REG_WIDTH-1:0] reg_array [0:NUM_REGISTERS-1];

    // Read Logic
    assign read_data1 = (rs1 != 5'b0) ? reg_array[rs1] : {REG_WIDTH{1'b0}}; // Register x0 is hardwired to 0
    assign read_data2 = (rs2 != 5'b0) ? reg_array[rs2] : {REG_WIDTH{1'b0}};

    // Write Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < NUM_REGISTERS; i++) begin
                reg_array[i] <= {REG_WIDTH{1'b0}}; // Reset all registers to zero
            end
        end else if (reg_write && rd != 5'b0) begin
            reg_array[rd] <= write_data; // Write to destination register if not x0
        end
    end

endmodule
