module io_controller (
    input logic clk,              // Clock signal
    input logic reset,            // Reset signal
    input logic [63:0] data_in,   // Data input from external device
    output logic [63:0] data_out, // Data output to external device
    input logic io_read,          // I/O read signal
    input logic io_write,         // I/O write signal
    output logic io_ready         // Indicates I/O operation is complete
);
    // Internal registers to hold the state of the controller
    logic [63:0] internal_data;   // Internal data register

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            internal_data <= 64'b0; // Reset internal data
            data_out <= 64'b0;      // Reset output data
            io_ready <= 1'b0;       // Reset ready signal
        end else begin
            if (io_write) begin
                internal_data <= data_in; // Store incoming data on write
                io_ready <= 1'b1;          // Indicate that write is complete
            end else if (io_read) begin
                data_out <= internal_data; // Output the internal data on read
                io_ready <= 1'b1;           // Indicate that read is complete
            end else begin
                io_ready <= 1'b0;           // No operation in progress
            end 
        end 
    end 
endmodule 
