module branch_predictor (
    input logic clk,
    input logic reset,
    input logic branch_taken,    // Signal indicating if the branch was taken or not
    input logic [63:0] pc_in,    // Renamed port to pc_in
    output logic predicted_taken // Prediction of whether the branch will be taken
);

    parameter HISTORY_SIZE = 16; // Size of history table
    logic [HISTORY_SIZE-1:0] history_table;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            history_table <= {HISTORY_SIZE{1'b0}};
            predicted_taken <= 1'b0;
        end else begin
            predicted_taken <= history_table[pc_in[3:0]]; // Simple prediction based on history table

            // Update history table based on actual outcome
            history_table[pc_in[3:0]] <= branch_taken;
        end
    end
endmodule
