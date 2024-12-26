module tb_register_file_64bit();

    // Testbench signals
    logic clk;
    logic reset;
    logic [4:0] rs1, rs2, rd;
    logic [63:0] write_data;
    logic reg_write;
    logic [63:0] read_data1, read_data2;

    // Instantiate the register file
    register_file_64bit uut (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        rs1 = 0; rs2 = 0; rd = 0;
        write_data = 0;
        reg_write = 0;

        // Apply reset
        #10 reset = 0;

        // Test Case 1: Write and read from registers
        reg_write = 1;
        rd = 5; write_data = 64'hA5A5A5A5A5A5A5A5; #10; // Write to register 5
        rd = 10; write_data = 64'h5A5A5A5A5A5A5A5A; #10; // Write to register 10
        reg_write = 0;

        // Read values back
        rs1 = 5; rs2 = 10; #10; // Read registers 5 and 10
        $display("Read Data1: %h, Read Data2: %h", read_data1, read_data2);

        // Test Case 2: Ensure x0 remains 0
        reg_write = 1;
        rd = 0; write_data = 64'hFFFFFFFFFFFFFFFF; #10; // Try to write to x0
        reg_write = 0;

        rs1 = 0; rs2 = 0; #10; // Read x0
        $display("Read Data1 (x0): %h, Read Data2 (x0): %h", read_data1, read_data2);

        // Test Case 3: Reset functionality
        reset = 1; #10;
        reset = 0; #10;
        rs1 = 5; rs2 = 10; #10; // Read registers 5 and 10 again
        $display("After reset - Read Data1: %h, Read Data2: %h", read_data1, read_data2);

        // End simulation
        $stop;
    end
endmodule
