module uart_tx_top (
    input clk,            // System clock
    input reset,          // Reset signal
    input [7:0] data_in, // Data to be transmitted
    input data_valid,     // Data valid signal
    output tx,            // Transmit signal
    output busy           // Busy signal indicating transmission status
);

    // Baud rate clock from the baud generator
    wire baud_clk;

    // Instantiate the baud generator
    baud_generator #(
        .baud_rate(104167)  // Set baud rate divisor for 9600 baud (approximately)
    ) baud_gen (
        .clk(clk),
        .reset(reset),
        .baud_rate(104167), // Baud rate value passed here
        .baud_clk(baud_clk)  // Output baud clock
    );

    // Instantiate the UART TX module
    uart_tx uart_tx_inst (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .data_valid(data_valid),
        .baud_clk(baud_clk), // Pass baud clock to UART TX
        .tx(tx),
        .busy(busy)
    );

endmodule
module uart_tx (
    input clk,               // System clock
    input reset,             // Reset signal
    input [7:0] data_in,     // Data to be transmitted (8 bits)
    input data_valid,        // Data valid signal
    input baud_clk,          // Baud clock generated by baud generator
    output reg tx,           // Transmit data bit
    output reg busy          // Indicates whether UART is busy transmitting data
);

    // Internal registers
    reg [7:0] data_reg;      // To store the data byte to be transmitted
    reg [3:0] bit_count;     // To count bits (8 bits for one byte)
    reg transmitting;        // To track if the UART is transmitting
    reg [3:0] shift_reg;     // Shift register for serial data transmission

    // State machine for UART transmission
    always @(posedge baud_clk or posedge reset) begin
        if (reset) begin
            tx <= 1'b1;            // Idle state for UART (1)
            busy <= 1'b0;          // Not busy initially
            bit_count <= 4'b0;     // Reset bit counter
            transmitting <= 1'b0;  // Not transmitting initially
        end else begin
            if (data_valid && !transmitting) begin
                // Start the transmission process
                transmitting <= 1'b1;
                data_reg <= data_in;   // Load data to be transmitted
                bit_count <= 4'b0;      // Reset bit counter
                shift_reg <= data_in;  // Load data into shift register
            end

            if (transmitting) begin
                if (bit_count < 8) begin
                    // Shift the bits out and transmit one bit at a time
                    tx <= shift_reg[0];      // Send the least significant bit
                    shift_reg <= shift_reg >> 1; // Shift data to the right
                    bit_count <= bit_count + 1;  // Increment bit counter
                end else begin
                    // Transmission complete, set to idle state
                    busy <= 1'b0;          // UART is no longer busy
                    transmitting <= 1'b0;  // Reset transmitting flag
                end
            end
        end
    end

endmodule
