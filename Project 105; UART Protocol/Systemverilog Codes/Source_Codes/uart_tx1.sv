module uart_tx1 (
    input wire clk,
    input wire rst,
    input wire baud_tick,
    input wire [7:0] data_in,
    input wire send,
    output reg tx_serial,
    output reg tx_done
);
    // State encoding
    typedef enum logic [2:0] {IDLE, START, DATA, STOP} state_t;
    state_t current_state, next_state;

    reg [3:0] bit_index; // To track the current bit being sent
    reg [7:0] shift_reg; // Shift register for data transmission

    // State transition logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE; // Initialize to IDLE on reset
            tx_serial <= 1; // Idle state is high
            tx_done <= 0; // Reset tx_done
            bit_index <= 0; // Reset bit index
        end else begin
            current_state <= next_state; // Update current state on clock edge
        end
    end

    // State machine logic
    always_comb begin
        // Default assignments to avoid latches
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (send) begin
                    next_state = START; // Transition to START on send
                end
            end

            START: begin
                next_state = DATA; // Transition to DATA after start bit
            end

            DATA: begin
                if (baud_tick) begin
                    if (bit_index == 7) begin
                        next_state = STOP; // Move to STOP after the last data bit
                    end
                end
            end

            STOP: begin
                if (baud_tick) begin
                    next_state = IDLE; // Return to IDLE after stop bit
                end
            end

            default: next_state = IDLE;
        endcase
    end

    // Output and data handling
    always_ff @(posedge clk) begin
        case (current_state)
            IDLE: begin
                tx_done <= 0;
                if (send) begin
                    shift_reg <= data_in; // Load data
                    bit_index <= 0;
                    tx_serial <= 1; // Idle state for serial line
                end
            end

            START: begin
                tx_serial <= 0; // Start bit
            end

            DATA: begin
                if (baud_tick) begin
                    tx_serial <= shift_reg[bit_index]; // Transmit current bit
                    bit_index <= bit_index + 1; // Move to the next bit
                end
            end

            STOP: begin
                if (baud_tick) begin
                    tx_serial <= 1; // Stop bit
                    tx_done <= 1; // Indicate completion
                end
            end
        endcase
    end

endmodule
