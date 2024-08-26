module project8(
    input  logic [15:0] A,
    input  logic [15:0] B,
    input  logic        Cin,
    output logic [15:0] Sum,
    output logic        Cout
);

    logic [15:0] G, P;          // Generate and Propagate
    logic [15:0] G1, P1;        // First stage
    logic [15:0] G2, P2;        // Second stage
    logic [15:0] G3, P3;        // Third stage
    logic [15:0] C;             // Carry

    // Generate and Propagate signals
    assign G = A & B;
    assign P = A ^ B;

    // First stage
    assign G1[0] = G[0];
    assign P1[0] = P[0];
    assign G1[1] = G[1] | (P[1] & G[0]);
    assign P1[1] = P[1] & P[0];
    assign G1[2] = G[2] | (P[2] & G[1]);
    assign P1[2] = P[2] & P[1];
    assign G1[3] = G[3] | (P[3] & G[2]);
    assign P1[3] = P[3] & P[2];
    assign G1[4] = G[4] | (P[4] & G[3]);
    assign P1[4] = P[4] & P[3];
    assign G1[5] = G[5] | (P[5] & G[4]);
    assign P1[5] = P[5] & P[4];
    assign G1[6] = G[6] | (P[6] & G[5]);
    assign P1[6] = P[6] & P[5];
    assign G1[7] = G[7] | (P[7] & G[6]);
    assign P1[7] = P[7] & P[6];
    assign G1[8] = G[8] | (P[8] & G[7]);
    assign P1[8] = P[8] & P[7];
    assign G1[9] = G[9] | (P[9] & G[8]);
    assign P1[9] = P[9] & P[8];
    assign G1[10] = G[10] | (P[10] & G[9]);
    assign P1[10] = P[10] & P[9];
    assign G1[11] = G[11] | (P[11] & G[10]);
    assign P1[11] = P[11] & P[10];
    assign G1[12] = G[12] | (P[12] & G[11]);
    assign P1[12] = P[12] & P[11];
    assign G1[13] = G[13] | (P[13] & G[12]);
    assign P1[13] = P[13] & P[12];
    assign G1[14] = G[14] | (P[14] & G[13]);
    assign P1[14] = P[14] & P[13];
    assign G1[15] = G[15] | (P[15] & G[14]);
    assign P1[15] = P[15] & P[14];

    // Second stage
    assign G2[1:0] = G1[1:0];
    assign P2[1:0] = P1[1:0];
    assign G2[2] = G1[2];
    assign P2[2] = P1[2];
    assign G2[3] = G1[3] | (P1[3] & G1[1]);
    assign P2[3] = P1[3] & P1[2];
    assign G2[4] = G1[4];
    assign P2[4] = P1[4];
    assign G2[5] = G1[5] | (P1[5] & G1[3]);
    assign P2[5] = P1[5] & P1[4];
    assign G2[6] = G1[6] | (P1[6] & G1[4]);
    assign P2[6] = P1[6] & P1[5];
    assign G2[7] = G1[7] | (P1[7] & G1[5]);
    assign P2[7] = P1[7] & P1[6];
    assign G2[8] = G1[8];
    assign P2[8] = P1[8];
    assign G2[9] = G1[9] | (P1[9] & G1[7]);
    assign P2[9] = P1[9] & P1[8];
    assign G2[10] = G1[10] | (P1[10] & G1[8]);
    assign P2[10] = P1[10] & P1[9];
    assign G2[11] = G1[11] | (P1[11] & G1[9]);
    assign P2[11] = P1[11] & P1[10];
    assign G2[12] = G1[12] | (P1[12] & G1[10]);
    assign P2[12] = P1[12] & P1[11];
    assign G2[13] = G1[13] | (P1[13] & G1[11]);
    assign P2[13] = P1[13] & P1[12];
    assign G2[14] = G1[14] | (P1[14] & G1[12]);
    assign P2[14] = P1[14] & P1[13];
    assign G2[15] = G1[15] | (P1[15] & G1[13]);
    assign P2[15] = P1[15] & P1[14];

    // Third stage
    assign G3[3:0] = G2[3:0];
    assign P3[3:0] = P2[3:0];
    assign G3[4] = G2[4];
    assign P3[4] = P2[4];
    assign G3[5] = G2[5];
    assign P3[5] = P2[5];
    assign G3[6] = G2[6];
    assign P3[6] = P2[6];
    assign G3[7] = G2[7] | (P2[7] & G2[3]);
    assign P3[7] = P2[7] & P2[6];
    assign G3[8] = G2[8];
    assign P3[8] = P2[8];
    assign G3[9] = G2[9];
    assign P3[9] = P2[9];
    assign G3[10] = G2[10];
    assign P3[10] = P2[10];
    assign G3[11] = G2[11] | (P2[11] & G2[7]);
    assign P3[11] = P2[11] & P2[10];
    assign G3[12] = G2[12] | (P2[12] & G2[8]);
    assign P3[12] = P2[12] & P2[11];
    assign G3[13] = G2[13] | (P2[13] & G2[9]);
    assign P3[13] = P2[13] & P2[12];
    assign G3[14] = G2[14] | (P2[14] & G2[10]);
    assign P3[14] = P2[14] & P2[13];
    assign G3[15] = G2[15] | (P2[15] & G2[11]);
    assign P3[15] = P2[15] & P2[14];

    // Final stage (Carries)
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & Cin);
    assign C[2] = G1[1] | (P1[1] & Cin);
    assign C[3] = G2[3] | (P2[3] & Cin);
    assign C[4] = G3[3] | (P3[3] & Cin);
    assign C[5] = G3[4] | (P3[4] & C[1]);
    assign C[6] = G3[5] | (P3[5] & C[2]);
    assign C[7] = G3[6] | (P3[6] & C[3]);
    assign C[8] = G3[7] | (P3[7] & C[4]);
    assign C[9] = G3[8] | (P3[8] & C[5]);
    assign C[10] = G3[9] | (P3[9] & C[6]);
    assign C[11] = G3[10] | (P3[10] & C[7]);
    assign C[12] = G3[11] | (P3[11] & C[8]);
    assign C[13] = G3[12] | (P3[12] & C[9]);
    assign C[14] = G3[13] | (P3[13] & C[10]);
    assign C[15] = G3[14] | (P3[14] & C[11]);

    // Sum and Cout
    assign Sum = P ^ C;
    assign Cout = G3[15] | (P3[15] & C[12]);

endmodule
