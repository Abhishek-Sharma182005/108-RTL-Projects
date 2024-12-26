
  module uart_rx1 (
    input wire clk,
    input wire rst,
    input wire rx_serial,
    input wire baud_tick,
    output reg [7:0] data_out,
    output reg rx_done
);

    typedef enum logic [2:0] {IDLE, START, DATA, STOP} state_t;
    state_t current_state, next_state;

    reg [3:0] bit_index; // To track the current bit being received
    reg [7:0] shift_reg; // Shift register for received data

    // State transition logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE; // Initialize to IDLE on reset
            rx_done <= 0; // Reset rx_done
            shift_reg <= 0; // Reset shift register
            bit_index <= 0; // Reset bit index
            $display("Time: %0t | Reset: Moving to IDLE state", $time);
        end else begin
            current_state <= next_state; // Update current state on clock edge
        end
    end

    // State machine logic
    always_ff @(posedge clk) begin
        case (current_state)
            IDLE: begin
                rx_done <= 0; // Reset rx_done in IDLE
                if (~rx_serial) begin // Start bit is low
                    next_state <= START;
                    $display("Time: %0t | Start bit detected, moving to START state", $time);
                end else begin
                    next_state <= IDLE;
                end
            end

            START: begin
                if (baud_tick) begin
                    next_state <= DATA; // Move to data state after start bit
                    bit_index <= 0; // Reset bit index
                    $display("Time: %0t | Start bit received", $time);
                end else begin
                    next_state <= START; // Wait for baud tick
                end
            end

            DATA: begin
                if (baud_tick) begin
                    shift_reg <= {rx_serial, shift_reg[7:1]}; // Shift in the received bit
                    $display("Time: %0t | Received Data Bit %b: %b", $time, bit_index, rx_serial);
                    if (bit_index == 7) begin
                        next_state <= STOP; // Move to STOP state after last data bit
                        $display("Time: %0t | Last data bit received, moving to STOP state", $time);
                    end else begin
                        bit_index <= bit_index + 1; // Move to next bit
                        next_state <= DATA;
                    end
                end else begin
                    next_state <= DATA; // Wait for baud tick
                end
            end

            STOP: begin
                if (baud_tick) begin
                    if (rx_serial == 1) begin // Stop bit should be high
                        data_out <= shift_reg;  // Load received data
                        rx_done <= 1;           // Indicate reception is done
                        $display("Time: %0t | Stop bit received, data_out: %h", $time, data_out);
                    end else begin
                        $display("Time: %0t | Error: Stop bit not high", $time);
                    end
                    next_state <= IDLE; // Move back to IDLE state
                end else begin
                    next_state <= STOP; // Wait for baud tick
                end
            end

            default: next_state <= IDLE;
        endcase
    end
endmodule

