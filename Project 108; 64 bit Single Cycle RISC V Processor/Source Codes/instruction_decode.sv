module instruction_decode (
    input logic [31:0] instruction, // 32-bit instruction input
    output logic [6:0] opcode,      // Opcode (7 bits)
    output logic [4:0] rs1,         // Source register 1 (5 bits)
    output logic [4:0] rs2,         // Source register 2 (5 bits)
    output logic [4:0] rd,          // Destination register (5 bits)
    output logic [2:0] func3,       // Function code 3 (3 bits)
    output logic [6:0] func7        // Function code 7 (7 bits)
);

    // Decode fields from the instruction
    assign opcode = instruction[6:0];      // Bits 0-6
    assign rs1    = instruction[19:15];    // Bits 15-19
    assign rs2    = instruction[24:20];    // Bits 20-24
    assign rd     = instruction[11:7];     // Bits 7-11
    assign func3  = instruction[14:12];    // Bits 12-14
    assign func7  = instruction[31:25];    // Bits 25-31

endmodule
