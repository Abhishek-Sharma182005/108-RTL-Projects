module debug_monitor (
    input logic clk,
    input logic [63:0] pc,          // Program Counter value 
    input logic [63:0] instruction, // Current instruction being executed 
    input logic [63:0] reg_file [31:0], // Register file state 
    output logic [255:0] debug_info // Debug information output 
);
    
    always_ff @(posedge clk) begin
        debug_info <= {pc, instruction, reg_file[0], reg_file[1], reg_file[2], reg_file[3]};
        // Format this output as needed for debugging purposes 
    end

endmodule
