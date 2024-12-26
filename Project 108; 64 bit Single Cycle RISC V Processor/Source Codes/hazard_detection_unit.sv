module hazard_detection_unit (
    input logic [4:0] rs1,         // Register 1 source
    input logic [4:0] rs2,         // Register 2 source
    input logic [4:0] rd_ex,       // Destination register from EX stage
    input logic [4:0] rd_mem,      // Destination register from MEM stage
    input logic mem_read_ex,       // MEM Read signal from EX stage
    input logic reg_write_ex,      // Register write signal from EX stage
    input logic reg_write_mem,     // Register write signal from MEM stage
    output logic stall,            // Stall signal to control pipeline
    output logic forward_data      // Forward data signal for data hazard
);

    always_comb begin
        stall = 0;      // Default no stall
        forward_data = 0; // Default no forwarding for data hazards

        // Check for data hazard: If rs1 or rs2 is the destination of a previous instruction
        if (mem_read_ex && (rs1 == rd_ex || rs2 == rd_ex)) begin
            stall = 1;  // Stall the pipeline
        end

        // Check for control hazards or forwarding data hazard
        if (reg_write_mem && (rs1 == rd_mem || rs2 == rd_mem)) begin
            forward_data = 1;  // Forward data if there is a data hazard
        end
    end
endmodule
