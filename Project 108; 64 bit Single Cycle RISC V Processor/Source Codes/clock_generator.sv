module clock_generator (
    output reg clk_out // Change to reg type
);
    // Define clock period in simulation time units
    parameter CLOCK_PERIOD = 1000; // Clock period in time units (1 GHz -> 1000 ns)

    // Initial block to set the initial state of the clock
    initial begin
        clk_out = 1'b0; // Initialize the clock signal to 0
    end

    // Always block to toggle the clock signal
    always begin
        #(CLOCK_PERIOD / 2) clk_out = ~clk_out; // Toggle the clock every half period
    end
endmodule
