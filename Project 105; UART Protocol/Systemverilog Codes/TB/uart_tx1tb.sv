module tb_uart_tx;

    parameter BAUD_RATE = 9600;
    parameter CLOCK_FREQ = 50000000;

    reg clk;
    reg rst;
    reg send;
    reg [7:0] data_in;
    wire tx_serial;
    wire tx_done;

    // Instantiate the baud rate generator
    wire baud_tick;
    baud_generator #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) baud_gen (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    // Instantiate the UART transmitter module
    uart_tx1 uart_transmitter (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .data_in(data_in),
        .send(send),
        .tx_serial(tx_serial),
        .tx_done(tx_done)
    );

    // Clock generation 
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate a clock with a period of 20 time units (50 MHz)
    end

    initial begin
        // Test sequence 
        rst = 1; 
        send = 0; 
        data_in = 8'hA5; // Example data to send
        
        #20 rst = 0; // Release reset
        
        #20 send = 1; // Start sending data
        
        #100 send = 0; // Keep send high longer for testing
        
        wait(tx_done); // Wait until transmission is done
        
        #10000 $finish; // End simulation after some time (10 ms)
    end

    // Monitor and display output signals 
    initial begin
        $monitor("Time: %0t | tx_serial: %b | tx_done: %b | Data Sent: %h", $time, tx_serial, tx_done, data_in);
        
        // Additional display for each bit sent 
        forever begin
            @(posedge baud_tick);
            $display("Time: %0t | baud_tick: %b", $time, baud_tick); // Monitor baud tick
            
            if (send) begin
                $display("Time: %0t | Sending Bit: %b", $time, tx_serial);
            end
            
            if (tx_done) begin
                $display("Time: %0t | Transmission Complete. Data Sent: %h", $time, data_in);
            end
            
            if (tx_serial == 1 && !send && !tx_done) begin 
                $display("Time: %0t | Idle State | tx_serial is High", $time);
            end 
        end 
    end 

endmodule // tb_uart_tx
