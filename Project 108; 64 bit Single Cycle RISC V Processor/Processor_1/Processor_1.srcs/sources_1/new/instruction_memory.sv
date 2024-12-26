module instruction_memory (
    input logic [63:0] address, // Input address for fetching instructions
    output logic [31:0] instruction // Output instruction
);
    logic [31:0] memory [0:1023]; // 4KB instruction memory (1024 x 32-bit)

    // Load sample instructions during initialization
    initial begin
        // Basic RISC-V Instructions
        memory[0]   = 32'h00000033; // ADD x0, x0, x0 (NOP)
        memory[1]   = 32'h00108093; // ADDI x1, x1, 1
        memory[2]   = 32'h00208113; // ADDI x2, x2, 2
        memory[3]   = 32'h002081b3; // ADD x3, x2, x2
        memory[4]   = 32'h00308093; // ADDI x4, x4, 3
        memory[5]   = 32'h00408113; // ADDI x5, x5, 4
        memory[6]   = 32'h005081b3; // ADD x6, x5, x5
        memory[7]   = 32'h00608233; // ADD x7, x3, x4
        memory[8]   = 32'h00f30313; // ADDI x6, x6, 15
        memory[9]   = 32'h00c303b3; // SUB x7, x6, x12

        // Additional Arithmetic Instructions (examples)
        memory[10]  = 32'h00a30313; // ADDI x6, x6, 10
        memory[11]  = 32'h00c303b3; // SUB x7, x6, x12

        // Memory Access Instructions (150)
        memory[12]  = 32'h00000003; // LB (Load Byte)
        memory[13]  = 32'h00000023; // SB (Store Byte)
        memory[14]  = 32'h00000003; // LH (Load Halfword)
        memory[15]  = 32'h00000023; // SH (Store Halfword)

        // Control Transfer Instructions (100)
        memory[16]  = 32'h0000006F; // JAL (Jump and Link)
        memory[17]  = 32'h00000067; // JALR (Jump and Link Register)

        // System Instructions (50)
        memory[18]  = 32'h00000073; // ECALL (Environment Call)

        // Floating-Point Instructions (150)
        memory[19]  = 32'h00000020; // FADD (Floating Point Add)

        // Atomic Operations (50)
        memory[20]  = 32'h00000001; // LR (Load Reserved)

        // Vector Instructions (200+)
        memory[21]  = 32'h00000002; // VADD (Vector Add)

        // Cryptography Extensions
        memory[22] = 32'hA001A001;   // AESENC 
        memory[23] = 32'hA001A002;   // AESDEC 
        memory[24] = 32'hA001A003;   // SHA256 
        memory[25] = 32'hA001A004;   // MODMUL 
        memory[26] = 32'hA001A005;   // MODINV 

        // AI/ML Extensions
        memory[27] = 32'hB001B001;   // VDOT 
        memory[28] = 32'hB001B002;   // VMATMUL 
        memory[29] = 32'hB001B003;   // VRELU 
        memory[30] = 32'hB001B004;   // VSIGMOID 

        // Application-Specific Instructions
        memory[31] = 32'hC001C001;   // FFTLOAD 
        memory[32] = 32'hC001C002;   // FFTEXEC 
        memory[33] = 32'hC001C003;   // IMGLOAD 
        memory[34] = 32'hC001C004;   // IMGCONV 

        // Processor Management Instructions
        memory[35] = 32'hD001D001;   // PMONSTART 
        memory[36] = 32'hD001D002;   // PMONSTOP 
        memory[37] = 32'hD001D003;   // DBGINST 
        memory[38] = 32'hD001D004;   // DBGDATA 

        // Initialize remaining entries to NOPs
        for (int i = 39; i < 1024; i++) begin
            memory[i] = 32'h00000033;  // NOP
        end
    end

    always_comb begin
        if (address[63:2] < 1024)  // Check if address is within bounds
            instruction = memory[address[11:2]];  // Word-aligned access
        else
            instruction = 32'h00000033;  // Return NOP if out of bounds
    end
endmodule
