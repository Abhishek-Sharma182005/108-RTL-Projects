module interrupt_controller (
    input logic clk,
    input logic reset,
    input logic interrupt_request, // Signal to indicate an interrupt request
    input logic [63:0] pc_in,      // Current program counter value
    output logic interrupt_acknowledge, // Acknowledge signal for interrupt handling
    output logic [63:0] pc_save     // Save the program counter for context switching
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            interrupt_acknowledge <= 1'b0;
            pc_save <= 64'b0;
        end else if (interrupt_request) begin
            interrupt_acknowledge <= 1'b1; // Acknowledge the interrupt request
            pc_save <= pc_in;              // Save the current PC value for context switch
        end else begin
            interrupt_acknowledge <= 1'b0;
        end
    end
endmodule
