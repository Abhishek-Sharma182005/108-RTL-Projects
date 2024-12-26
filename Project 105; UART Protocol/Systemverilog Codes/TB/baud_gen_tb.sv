// Testbench for Baud Rate Generator
module baud_gen_tb;
    reg clk;
    reg rst;
    wire baud_tick;

    // Instantiate the Baud Rate Generator
    baud_generator #(.BAUD_RATE(9600), .CLOCK_FREQ(50000000)) uut (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    // Clock generation (50 MHz)
    initial clk = 0;
    always #10 clk = ~clk; // 20 ns clock period

    // Testbench procedure
    initial begin
        $display("Calculated TICKS: %d", uut.TICKS); // Display calculated TICKS value
        $monitor("Time: %t | Tick Counter: %d | Baud Tick: %b", $time, uut.tick_counter, baud_tick);

        // Reset the system
        rst = 1;
        #50 rst = 0;

        // Run simulation for a longer duration (30ms) to capture more baud ticks
        #30000000; // Run for 30ms (enough for multiple baud ticks)

        $finish;
    end
endmodule
