module program_counter (
    input logic clk,
    input logic reset,
    input logic [63:0] pc_in, // Input for PC update (could be next PC or jump target)
    output logic [63:0] pc_out // Current PC value
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 64'b0; // Reset PC to 0
        else
            pc_out <= pc_out + 4; // Increment PC by 4 for next instruction
    end
endmodule
