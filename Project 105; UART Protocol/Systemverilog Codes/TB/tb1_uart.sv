//its rx testbench
module tb1_uart;


    // Parameters for baud rate and clock frequency
    parameter BAUD_RATE = 9600;
    parameter CLOCK_FREQ = 50000000;

    // Signals
    reg clk;
    reg rst;
    reg rx_serial;
    reg baud_tick;
    wire [7:0] data_out;
    wire rx_done;

    // Instantiate the receiver module
    uart_rx1 uut (
        .clk(clk),
        .rst(rst),
        .rx_serial(rx_serial),
        .baud_tick(baud_tick),
        .data_out(data_out),
        .rx_done(rx_done)
    );

    // Instantiate the baud generator
    baud_generator #(
        .BAUD_RATE(BAUD_RATE),
        .CLOCK_FREQ(CLOCK_FREQ)
    ) baud_gen (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    // Clock generation
    always #10 clk = ~clk; // 50 MHz clock

    // Serial transmission task
    task send_serial_data(input [7:0] data);
        integer i;
        begin
            // Send start bit (0)
            rx_serial = 0;
            @(posedge baud_tick);
            
            // Send 8 data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx_serial = data[i];
                @(posedge baud_tick);
            end

            // Send stop bit (1)
            rx_serial = 1;
            @(posedge baud_tick);
        end
    endtask

    // Testbench procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        rx_serial = 1; // Idle state for serial line
        #50 rst = 0;   // Release reset

        // Wait for some time
        #100;

        // Transmit first byte: 0xAA
        $display("Time: %0t | Sending byte: 0xAA", $time);
        send_serial_data(8'hAA);
        wait(rx_done);
        $display("Time: %0t | Received byte: 0x%h | rx_done: %b", $time, data_out, rx_done);

        // Transmit second byte: 0xCC
        #100; // Wait before sending next byte
        $display("Time: %0t | Sending byte: 0xCC", $time);
        send_serial_data(8'hCC);
        wait(rx_done);
        $display("Time: %0t | Received byte: 0x%h | rx_done: %b", $time, data_out, rx_done);

        // End simulation
        #100;
        $finish;
    end
endmodule
