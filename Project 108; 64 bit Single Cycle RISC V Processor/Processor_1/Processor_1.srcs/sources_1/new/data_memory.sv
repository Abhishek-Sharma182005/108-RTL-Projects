module data_memory (
    input logic clk,                  // Clock signal
    input logic [63:0] address,       // Address to read/write data
    input logic [63:0] write_data,    // Data to be written (for store)
    input logic mem_write,            // Memory write enable
    input logic mem_read,             // Memory read enable
    output logic [63:0] read_data     // Data read from memory
);
    // Memory declaration: 64-bit words, 1024 words
    logic [63:0] memory [0:1023];

    always_ff @(posedge clk) begin
        if (mem_read) begin
            if (address[9:0] < 1024) begin // Ensure address is within bounds
                read_data <= memory[address[9:0]]; // Read data from specified address
            end else begin
                read_data <= 64'b0; // Return zero for out-of-bounds access
            end
        end
        
        if (mem_write) begin
            if (address[9:0] < 1024) begin // Ensure address is within bounds
                memory[address[9:0]] <= write_data; // Store data at specified address
            end
        end
    end

endmodule
