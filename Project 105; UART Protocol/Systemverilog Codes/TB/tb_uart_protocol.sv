`timescale 1ns/1ps

module tb_uart_protocol1;
    // Parameters
    parameter BAUD_RATE = 9600;
    parameter CLOCK_FREQ = 50000000;

    // Signals
    reg clk;
    reg rst;
    reg [7:0] tx_data;
    reg tx_start;
    wire tx_serial;
    wire [7:0] rx_data;
    wire tx_done;
    wire rx_done;
    reg rx_serial;

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    // Instantiate the UART protocol module
    uart_protocol1 #(
        .BAUD_RATE(BAUD_RATE),
        .CLOCK_FREQ(CLOCK_FREQ)
    ) uut (
        .clk(clk),
        .rst(rst),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .rx_serial(rx_serial),
        .tx_serial(tx_serial),
        .rx_data(rx_data),
        .tx_done(tx_done),
        .rx_done(rx_done)
    );

    // Task for applying reset
    task apply_reset();
        begin
            rst = 1;
            #100; // Hold reset for 100 ns
            rst = 0;
        end
    endtask

    // Task to send and verify UART data
    task send_data(input [7:0] data_to_send);
        begin
            tx_data = data_to_send;
            tx_start = 1;
            #20 tx_start = 0; // Clear start signal

            wait(tx_done); // Wait until transmission is done
            $display("Time: %0t | Sent Data: 0x%02h", $time, data_to_send);

            wait(rx_done); // Wait until reception is done
            if (rx_data == data_to_send) begin
                $display("Time: %0t | Received Data: 0x%02h | Test Passed", $time, rx_data);
            end else begin
                $fatal("Time: %0t | Received Data: 0x%02h | Test Failed", $time, rx_data);
            end
        end
    endtask

    // Loopback: Drive RX serial input with TX serial output
    always @(posedge clk) begin
        rx_serial <= tx_serial;
    end

    // Testbench logic
    initial begin
        $display("Starting UART Protocol Testbench...");

        // Apply reset
        apply_reset();

        // Test case 1: Send 0xAA
        send_data(8'hAA);

        // Test case 2: Send 0x3C
        send_data(8'h3C);

        // Simulation complete
        $display("Simulation Complete: All tests passed.");
        #100 $finish;
    end
endmodule
