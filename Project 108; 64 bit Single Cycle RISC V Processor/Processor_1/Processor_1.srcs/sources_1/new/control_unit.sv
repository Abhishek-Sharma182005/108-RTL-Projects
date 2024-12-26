module control_unit (
    input logic [6:0] opcode,
    input logic [2:0] func3,
    input logic [6:0] func7,
    output logic [3:0] alu_control,
    output logic reg_write,
    output logic mem_read,
    output logic mem_write,
    output logic branch,
    output logic mem_to_reg,
    output logic alu_src
);

    always_comb begin
        // Default values
        alu_control = 4'b0000; // Default: ADD
        reg_write = 0;
        mem_read = 0;
        mem_write = 0;
        branch = 0;
        mem_to_reg = 0;
        alu_src = 0;

        case (opcode)
            7'b0110011: begin // R-type
                reg_write = 1;
                case (func3)
                    3'b000: begin // ADD or SUB
                        if (func7 == 7'b0000000) alu_control = 4'b0000; // ADD
                        else if (func7 == 7'b0100000) alu_control = 4'b0001; // SUB
                    end
                    // Handle other func3 values for R-type operations here
                endcase
            end
            7'b0010011: begin // I-type (e.g., ADDI)
                reg_write = 1;
                alu_src = 1; // Second operand is an immediate value
                case (func3)
                    3'b000: alu_control = 4'b0000; // ADD
                    // Add more cases for other I-type operations
                endcase
            end
            7'b0000011: begin // Load (e.g., LW)
                reg_write = 1;
                mem_read = 1;
                alu_control = 4'b0000; // ADD for address calculation
                mem_to_reg = 1; // Data comes from memory
            end
            7'b0100011: begin // Store (e.g., SW)
                mem_write = 1;
                alu_control = 4'b0000; // ADD for address calculation
            end
            7'b1100011: begin // Branch (e.g., BEQ)
                branch = 1;
                alu_control = 4'b0001; // SUB for comparison
            end
            // Add more cases for other instruction types here
        endcase
    end
endmodule
