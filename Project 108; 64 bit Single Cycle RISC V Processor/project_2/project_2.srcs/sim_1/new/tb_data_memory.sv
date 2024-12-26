module tb_data_memory;
    logic clk;                          // Clock signal
    logic [63:0] address;               // Address to read/write data
    logic [63:0] write_data;            // Data to be written (for store)
    logic mem_write;                    // Memory write enable
    logic mem_read;                     // Memory read enable
    logic [63:0] read_data;             // Data read from memory

    // Instantiate the data memory
    data_memory uut (
        .clk(clk),
        .address(address),
        .write_data(write_data),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .read_data(read_data)
    );

    initial begin
        // Initialize clock
        clk = 0;
        forever #5 clk = ~clk; // Generate a clock with a period of 10 time units
    end

    initial begin
        // Test Case 1: Write and Read Back
        address = 64'h0000000000000000; // Address 0
        write_data = 64'hDEADBEEFCAFEBABE; // Sample data to write
        mem_write = 1; // Enable write
        mem_read = 0;  // Disable read
        #10;           // Wait for a clock cycle

        mem_write = 0; // Disable write for the next operation
        mem_read = 1;  // Enable read
        #10;           // Wait for a clock cycle

        assert(read_data == 64'hDEADBEEFCAFEBABE) else $fatal("Test Case 1 Failed: Expected %h, got %h", 64'hDEADBEEFCAFEBABE, read_data);

        // Test Case 2: Write to another address and read back
        address = 64'h0000000000000001; // Address 1
        write_data = 64'h123456789ABCDEF0; // Sample data to write
        mem_write = 1; 
        mem_read = 0;
        #10;

        mem_write = 0;
        mem_read = 1;
        #10;

        assert(read_data == 64'h123456789ABCDEF0) else $fatal("Test Case 2 Failed: Expected %h, got %h", 64'h123456789ABCDEF0, read_data);

        // Test Case 3: Out-of-bounds write (should not change memory)
        address = 64'h0000000000040000; // Out-of-bounds address (greater than max)
        write_data = 64'hFFFFFFFFFFFFFFFF; 
        mem_write = 1;
        mem_read = 0;
        #10;

        mem_write = 0;
        
        // Check that the previous valid address still holds its value
        address = 64'h0000000000000000; 
        mem_read = 1;
        #10;

        assert(read_data == 64'hDEADBEEFCAFEBABE) else $fatal("Test Case 3 Failed: Expected %h, got %h", 64'hDEADBEEFCAFEBABE, read_data);

        // Test Case 4: Read from an out-of-bounds address
        address = 64'h0000000000040000; // Out-of-bounds address (greater than max)
        
        mem_write = 0;
        mem_read = 1;
        #10;

        assert(read_data == 64'b0) else $fatal("Test Case 4 Failed: Expected %h, got %h", 64'b0, read_data);

        $display("All tests passed!");
        
        $finish;
    end
endmodule
