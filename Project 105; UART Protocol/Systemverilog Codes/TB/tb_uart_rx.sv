module tb_uart_rx;

    parameter BAUD_RATE = 9600;
    parameter CLOCK_FREQ = 50000000;

    reg clk;
    reg rst;
    reg uart_rxd; // Input for receiving UART data
    wire uart_rx_valid;
    wire [7:0] uart_rx_data;

    // Instantiate the UART receiver module
    uart_rx uut (
        .clk(clk),
        .rst(rst),
        .uart_rxd(uart_rxd),
        .uart_rx_valid(uart_rx_valid),
        .uart_rx_data(uart_rx_data)
    );

    // Clock generation 
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate a clock with a period of 20 time units (50 MHz)
    end

    initial begin
        rst = 1; 
        uart_rxd = 1; // Idle state is high
        
        #20 rst = 0; // Release reset
        
        #20 send_byte_task(8'hA5); // Send example byte A5
        
        #100 $finish; // End simulation after some time
    end

    // Task for sending a byte of data via UART
    task send_byte_task(input [7:0] data);
        integer i;
        
        // Start Bit (low)
        uart_rxd = 0; // Start bit is low
        #10417; // Wait for one baud period
        
        for (i = 0; i < 8; i = i + 1) begin
            uart_rxd = data[i]; // Send each data bit 
            $display("Time: %0t | Sending Bit: %b", $time, uart_rxd);
            #10417; // Wait for one baud period between bits 
        end
        
        // Stop Bit (high)
        uart_rxd = 1; // Stop bit is high
        #10417; // Wait for one baud period for stop bit
        
        $display("Time: %0t | Sent Byte: %h", $time, data);
        
        wait(uart_rx_valid); // Wait until valid data is received
        
        $display("Time: %0t | Data received, valid signal asserted. Received Byte: %h", $time, uart_rx_data);
        
    endtask

    // Monitor the state of uart_rx_valid and received data
    initial begin
        forever begin
            @(posedge clk);
            if (uart_rx_valid) begin
                $display("Time: %0t | Valid Data Received: %h", $time, uart_rx_data);
            end else begin
                $display("Time: %0t | Waiting for valid data...", $time);
            end
        end
    end

endmodule // tb_uart_rx
