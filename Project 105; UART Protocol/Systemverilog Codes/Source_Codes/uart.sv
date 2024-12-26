// UART Module
module uart #(parameter BAUD_RATE = 9600, CLOCK_FREQ = 50000000)(
    input wire clk,
    input wire rst,
    input wire rx,
    output wire tx,
    input wire [7:0] data_in,
    input wire data_valid,
    output wire [7:0] data_out,
    output wire data_ready
);

    wire baud_tick;

    // Instantiate Baud Rate Generator
    baud_gen #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) baud_gen_inst (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    // Internal signals
    reg [7:0] rx_shift_reg;
    reg [7:0] tx_shift_reg;
    reg [3:0] rx_bit_count;
    reg [3:0] tx_bit_count;
    reg rx_busy;
    reg tx_busy;
    reg rx_data_ready;

    assign data_out = rx_shift_reg;
    assign data_ready = rx_data_ready;
    assign tx = tx_busy ? tx_shift_reg[0] : 1'b1;

    // RX Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_busy <= 0;
            rx_bit_count <= 0;
            rx_shift_reg <= 0;
            rx_data_ready <= 0;
        end else if (baud_tick) begin
            if (!rx_busy) begin
                if (rx == 0) begin // Start bit detected
                    rx_busy <= 1;
                    rx_bit_count <= 0;
                    rx_data_ready <= 0;
                end
            end else begin
                rx_bit_count <= rx_bit_count + 1;

                if (rx_bit_count == 0) begin
                    // Start bit, do nothing
                end else if (rx_bit_count <= 8) begin
                    rx_shift_reg <= {rx, rx_shift_reg[7:1]};
                end else if (rx_bit_count == 9) begin
                    rx_busy <= 0;
                    rx_data_ready <= 1;
                end
            end
        end
    end

    // TX Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_busy <= 0;
            tx_bit_count <= 0;
            tx_shift_reg <= 0;
        end else if (baud_tick) begin
            if (!tx_busy) begin
                if (data_valid) begin
                    tx_busy <= 1;
                    tx_shift_reg <= {1'b1, data_in, 1'b0}; // Stop bit, data, start bit
                    tx_bit_count <= 0;
                end
            end else begin
                tx_bit_count <= tx_bit_count + 1;
                tx_shift_reg <= {1'b1, tx_shift_reg[7:1]};

                if (tx_bit_count == 9) begin
                    tx_busy <= 0;
                end
            end
        end
    end

endmodule

