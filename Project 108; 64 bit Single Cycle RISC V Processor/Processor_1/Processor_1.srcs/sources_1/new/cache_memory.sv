module cache_memory (
    input logic clk,
    input logic [63:0] address, // Address for read/write
    input logic [63:0] write_data, // Data to write
    input logic mem_read,       // Memory read enable
    input logic mem_write,      // Memory write enable
    output logic [63:0] read_data // Data read from cache
);
    parameter CACHE_SIZE = 512; // Cache size in bytes
    parameter BLOCK_SIZE = 16;   // Block size in bytes
    parameter NUM_BLOCKS = CACHE_SIZE / BLOCK_SIZE; // Number of blocks

    logic [63:0] cache_data [0:NUM_BLOCKS-1]; // Cache data array
    logic [5:0] cache_tags [0:NUM_BLOCKS-1];   // Cache tags
    logic cache_valid [0:NUM_BLOCKS-1];         // Valid bits

    always_ff @(posedge clk) begin
        if (mem_write) begin
            int index = address[5:2]; // Calculate index (4 bits)
            cache_data[index] <= write_data; // Write data to cache
            cache_tags[index] <= address[11:6]; // Update tag
            cache_valid[index] <= 1'b1; // Set valid bit
        end
    end

    always_ff @(posedge clk) begin
        if (mem_read) begin
            int index = address[5:2]; // Calculate index (4 bits)
            if (cache_valid[index] && (cache_tags[index] == address[11:6])) begin
                read_data <= cache_data[index]; // Hit: Read from cache
            end else begin
                read_data <= 64'b0; // Miss: Return zero or handle miss accordingly
            end
        end
    end
endmodule
