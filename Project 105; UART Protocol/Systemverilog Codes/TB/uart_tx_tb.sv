module uart_tx_tb;

    // Inputs to the UART TX module
    reg clk;
    reg reset;
    reg [7:0] data_in;
    reg data_valid;
    
    // Outputs from the UART TX module
    wire tx;
    wire busy;
    
    // Baud rate clock (from the baud generator)
    wire baud_clk;

    // Instantiate the top-level module
    uart_tx_top uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .data_valid(data_valid),
        .tx(tx),
        .busy(busy)
    );

    // Clock generation (100 MHz system clock)
    always begin
        #5 clk = ~clk;  // 10 ns period = 100 MHz clock
    end

    // Stimulus generation
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        data_in = 8'b0;
        data_valid = 0;

        // Apply reset
        #10 reset = 1;  // Assert reset for 10 ns
        #10 reset = 0;  // Deassert reset

        // Send data
        #20 data_in = 8'b10101010;  // 8-bit data to send (10101010)
        data_valid = 1;              // Data valid signal high
        #10 data_valid = 0;          // Deassert data valid signal

        // Wait for transmission to complete
        #1000;

        // Send another data word
        #20 data_in = 8'b11001100;  // New data (11001100)
        data_valid = 1;              // Data valid signal high
        #10 data_valid = 0;          // Deassert data valid signal

        // Wait for transmission to complete
        #1000;

        // Finish simulation
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time: %t | tx: %b | data_in: %b | busy: %b", $time, tx, data_in, busy);
    end

endmodule
