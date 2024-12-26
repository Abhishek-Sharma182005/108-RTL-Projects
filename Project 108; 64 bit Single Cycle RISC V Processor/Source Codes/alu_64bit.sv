module alu_64bit (
    input logic [63:0] a,       // Operand A
    input logic [63:0] b,       // Operand B
    input logic [3:0] alu_ctrl, // ALU control signal
    output logic [63:0] result, // Result of the operation
    output logic zero           // Zero flag
);

    // ALU control signal encoding
    localparam ADD  = 4'b0000; // Addition
    localparam SUB  = 4'b0001; // Subtraction
    localparam AND  = 4'b0010; // Logical AND
    localparam OR   = 4'b0011; // Logical OR
    localparam XOR  = 4'b0100; // Logical XOR
    localparam SLL  = 4'b0101; // Logical left shift
    localparam SRL  = 4'b0110; // Logical right shift
    localparam SRA  = 4'b0111; // Arithmetic right shift

    always_comb begin
        case (alu_ctrl)
            ADD:  result = a + b;
            SUB:  result = a - b;
            AND:  result = a & b;
            OR:   result = a | b;
            XOR:  result = a ^ b;
            SLL:  result = a << b[5:0]; // Shift amount limited to 6 bits
            SRL:  result = a >> b[5:0];
            SRA:  result = $signed(a) >>> b[5:0];
            default: begin
                result = 64'b0;      // Default case for invalid operation
                zero = 1'b1;         // Set zero flag if invalid operation occurs
            end
        endcase
        
        // Zero flag: Asserted if the result is zero
        zero = (result == 64'b0);
    end

endmodule
