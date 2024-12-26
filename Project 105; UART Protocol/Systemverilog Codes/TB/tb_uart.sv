// Testbench for UART
module tb_uart;

    // Testbench signals
    reg clk;
    reg rst;
    reg rx;
    wire tx;
    reg [7:0] data_in;
    wire [7:0] data_out;
    reg data_valid;
    wire data_ready;

    // Instantiate the UART module
    uart #(.BAUD_RATE(9600), .CLOCK_FREQ(50000000)) uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx),
        .data_in(data_in),
        .data_valid(data_valid),
        .data_out(data_out),
        .data_ready(data_ready)
    );

    // Clock generation (50 MHz)
    initial clk = 0;
    always #10 clk = ~clk; // 20 ns clock period

    // Testbench procedure
    initial begin
        // Monitor outputs
        $monitor("Time: %t | Data In: %h | Data Out: %h | TX: %b | RX: %b | Data Ready: %b", 
                  $time, data_in, data_out, tx, rx, data_ready);

        // Reset the system
        rst = 1;
        rx = 1;
        data_in = 8'b0;
        data_valid = 0;
        #100 rst = 0;

        // Transmit data
        send_data(8'hA5); // Transmit byte 0xA5
        #100000; // Wait for transmission to complete

        // Simulate RX reception of data
        receive_data(8'h5A); // Receive byte 0x5A
        #50000;

        $finish;
    end

    // Task to simulate data transmission
    task send_data(input [7:0] data);
        begin
            data_in = data;
            data_valid = 1;
            #20;
            data_valid = 0;
        end
    endtask

    // Task to simulate data reception
    task receive_data(input [7:0] data);
        integer i;
        begin
            // Start bit
            rx = 0;
            #(5208 * 10); // Baud period

            // Data bits
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(5208 * 10);
            end

            // Stop bit
            rx = 1;
            #(5208 * 10);
        end
    endtask

endmodule
