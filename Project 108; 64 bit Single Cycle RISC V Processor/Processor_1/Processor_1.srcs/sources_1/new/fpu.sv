module fpu (
    input logic clk,
    input logic reset,
    input logic [31:0] operand_a,
    input logic [31:0] operand_b,
    input logic [2:0] operation, // 000: ADD, 001: SUB, 010: MUL, 011: DIV
    output logic [31:0] result,
    output logic valid // Indicates if the result is valid
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            result <= 32'b0;
            valid <= 1'b0;
        end else begin
            case (operation)
                3'b000: result <= operand_a + operand_b; // ADD
                3'b001: result <= operand_a - operand_b; // SUB
                3'b010: result <= operand_a * operand_b; // MUL
                3'b011: result <= operand_a / operand_b; // DIV
                default: result <= 32'b0; // Default case
            endcase
            valid <= 1'b1; // Result is valid after operation
        end
    end
endmodule
