module Traffic_Selector(
    input NS1, NS2, EW1, EW2,   // Inputs corresponding to the traffic signals
    output O1, O2, O3, O4, O5, O6, O7, O8, O9  // Outputs based on the logic given
);

// Inverters for the inputs
wire NS1_n, NS2_n, EW1_n, EW2_n;
not (NS1_n, NS1);
not (NS2_n, NS2);
not (EW1_n, EW1);
not (EW2_n, EW2);

// O1 = NS1'NS2'EW1'EW2'
and (O1, NS1_n, NS2_n, EW1_n, EW2_n);

// O2 = NS1'NS2'EW1'EW2
and (O2, NS1_n, NS2_n, EW1_n, EW2);

// O3 = NS1'NS2EW1'EW2'
and (O3, NS1_n, NS2_n, EW1, EW2_n);

// O4 = NS1'EW1'EW2'
and (O4, NS1_n, EW1_n, EW2_n);

// O5 = EW1EW2 + EW1NS2 + NS1NS2
wire EW1_EW2, EW1_NS2, NS1_NS2;
and (EW1_EW2, EW1, EW2);
and (EW1_NS2, EW1, NS2);
and (NS1_NS2, NS1, NS2);
or (O5, EW1_EW2, EW1_NS2, NS1_NS2);

// O6 = NS1'EW1EW2'
and (O6, NS1_n, EW1, EW2_n);

// O7 = NS1NS2'EW1'EW2'
and (O7, NS1, NS2_n, EW1_n, EW2_n);

// O8 = NS1NS2'EW1'EW2
and (O8, NS1, NS2_n, EW1_n, EW2);

// O9 = NS1NS2EW1EW2'
and (O9, NS1, NS2, EW1, EW2_n);

endmodule

module Enable_and_UpDown (
    input rst,      // Reset signal (0 or 1)
    input O1, O2, O3, O4, O5, O6, O7, O8, O9,  // Inputs O1 to O9
    output R1, R2, R3, R4, R5, R6, R7, R8, R9 // Outputs R1 to R9
);

    // XOR gates for each Ri = xor(rst, Oi)
    xor (R1, rst, O1);  // R1 = rst XOR O1
    xor (R2, rst, O2);  // R2 = rst XOR O2
    xor (R3, rst, O3);  // R3 = rst XOR O3
    xor (R4, rst, O4);  // R4 = rst XOR O4
    xor (R5, rst, O5);  // R5 = rst XOR O5
    xor (R6, rst, O6);  // R6 = rst XOR O6
    xor (R7, rst, O7);  // R7 = rst XOR O7
    xor (R8, rst, O8);  // R8 = rst XOR O8
    xor (R9, rst, O9);  // R9 = rst XOR O9

endmodule
module UpDownCounter (
    input clk,         // Clock signal
    input rst,         // Reset signal
    input enable,      // Enable signal (counting only when enable is high)
    input up_down,     // Up/Down control (1 = count up, 0 = count down)
    output A, B, C, D, E, F  // 6-bit output (A is MSB, F is LSB)
);
    // Internal wires for flip-flop outputs and logic
    wire qA, qB, qC, qD, qE, qF; // Flip-flop outputs
    wire dA, dB, dC, dD, dE, dF; // D inputs for flip-flops
    wire not_up_down;  // Inverted up_down signal
    wire and_enable_up, and_enable_down;  // AND gates for enable and up/down control

    // Invert up_down signal
    not(not_up_down, up_down);

    // A bit (MSB)
    xor(dA, qA, (enable & up_down));  // T-flip flop behavior using XOR for counting
    dff ffA(.clk(clk), .rst(rst), .d(dA), .q(qA));
    
    // B bit
    wire andAB;
    and(andAB, qA, enable);  // Toggle when A flips
    xor(dB, qB, (andAB & up_down));  // T-flip flop with enable and up/down
    dff ffB(.clk(clk), .rst(rst), .d(dB), .q(qB));
    
    // C bit
    wire andBC;
    and(andBC, qA, qB, enable);  // Toggle when both A and B flip
    xor(dC, qC, (andBC & up_down));  // T-flip flop with enable and up/down
    dff ffC(.clk(clk), .rst(rst), .d(dC), .q(qC));
    
    // D bit
    wire andCD;
    and(andCD, qA, qB, qC, enable);  // Toggle when A, B, and C flip
    xor(dD, qD, (andCD & up_down));  // T-flip flop with enable and up/down
    dff ffD(.clk(clk), .rst(rst), .d(dD), .q(qD));
    
    // E bit
    wire andDE;
    and(andDE, qA, qB, qC, qD, enable);  // Toggle when A, B, C, and D flip
    xor(dE, qE, (andDE & up_down));  // T-flip flop with enable and up/down
    dff ffE(.clk(clk), .rst(rst), .d(dE), .q(qE));
    
    // F bit (LSB)
    wire andEF;
    and(andEF, qA, qB, qC, qD, qE, enable);  // Toggle when A, B, C, D, and E flip
    xor(dF, qF, (andEF & up_down));  // T-flip flop with enable and up/down
    dff ffF(.clk(clk), .rst(rst), .d(dF), .q(qF));

    // Output assignment
    assign A = qA;
    assign B = qB;
    assign C = qC;
    assign D = qD;
    assign E = qE;
    assign F = qF;

endmodule
module UpDownCounter4bit (
    input clk,          // Clock signal
    input rst,          // Reset signal (active high)
    input enable,       // Enable signal (when 1, counting is enabled)
    input up_down,      // Up/Down control (1 = Up, 0 = Down)
    output A, B, C, D   // 4-bit output (A is MSB, D is LSB)
);

    wire qA, qB, qC, qD;    // Outputs of flip-flops
    wire dA, dB, dC, dD;    // D inputs for the flip-flops
    wire tA, tB, tC, tD;    // T inputs for toggling the counter
    wire not_up_down;        // Inverted up_down signal
    wire and_enable_tA, and_enable_tB, and_enable_tC, and_enable_tD; // AND gates for enable and T-flip control

    // Invert up_down signal
    not(not_up_down, up_down);

    // T-Flip Flop logic using XOR gates for Up/Down control
    // If up_down = 1, the counter counts up, otherwise it counts down.

    // Flip-flop for A (MSB)
    xor(tA, qA, up_down);             // Toggle A based on up_down signal
    and(and_enable_tA, enable, tA);   // Enable control for flip-flop A
    xor(dA, qA, and_enable_tA);       // D input for flip-flop A
    dff ffA(.clk(clk), .rst(rst), .d(dA), .q(qA));

    // Flip-flop for B
    xor(tB, qB, qA);                  // T-flip flop toggling based on previous bit (A)
    xor(tB_up, tB, up_down);          // XOR for up/down control
    and(and_enable_tB, enable, tB_up);
    xor(dB, qB, and_enable_tB);
    dff ffB(.clk(clk), .rst(rst), .d(dB), .q(qB));

    // Flip-flop for C
    xor(tC, qC, qB);                  // T-flip flop toggling based on previous bit (B)
    xor(tC_up, tC, up_down);
    and(and_enable_tC, enable, tC_up);
    xor(dC, qC, and_enable_tC);
    dff ffC(.clk(clk), .rst(rst), .d(dC), .q(qC));

    // Flip-flop for D (LSB)
    xor(tD, qD, qC);                  // T-flip flop toggling based on previous bit (C)
    xor(tD_up, tD, up_down);
    and(and_enable_tD, enable, tD_up);
    xor(dD, qD, and_enable_tD);
    dff ffD(.clk(clk), .rst(rst), .d(dD), .q(qD));

    // Output assignment
    assign A = qA;
    assign B = qB;
    assign C = qC;
    assign D = qD;

endmodule
module UpDownCounter5bit (
    input clk,          // Clock signal
    input rst,          // Reset signal (active high)
    input enable,       // Enable signal (when 1, counting is enabled)
    input up_down,      // Up/Down control (1 = Up, 0 = Down)
    output A, B, C, D, E  // 5-bit output (A is MSB, E is LSB)
);

    wire qA, qB, qC, qD, qE;  // Outputs of flip-flops
    wire dA, dB, dC, dD, dE;  // D inputs for the flip-flops
    wire tA, tB, tC, tD, tE;  // T inputs for toggling the counter
    wire not_up_down;          // Inverted up_down signal
    wire and_enable_tA, and_enable_tB, and_enable_tC, and_enable_tD, and_enable_tE; // AND gates for enable and T-flip control

    // Invert up_down signal
    not(not_up_down, up_down);

    // T-Flip Flop logic using XOR gates for Up/Down control
    // If up_down = 1, the counter counts up, otherwise it counts down.

    // Flip-flop for A (MSB)
    xor(tA, qA, up_down);             // Toggle A based on up_down signal
    and(and_enable_tA, enable, tA);   // Enable control for flip-flop A
    xor(dA, qA, and_enable_tA);       // D input for flip-flop A
    dff ffA(.clk(clk), .rst(rst), .d(dA), .q(qA));

    // Flip-flop for B
    xor(tB, qB, qA);                  // T-flip flop toggling based on previous bit (A)
    xor(tB_up, tB, up_down);          // XOR for up/down control
    and(and_enable_tB, enable, tB_up);
    xor(dB, qB, and_enable_tB);
    dff ffB(.clk(clk), .rst(rst), .d(dB), .q(qB));

    // Flip-flop for C
    xor(tC, qC, qB);                  // T-flip flop toggling based on previous bit (B)
    xor(tC_up, tC, up_down);
    and(and_enable_tC, enable, tC_up);
    xor(dC, qC, and_enable_tC);
    dff ffC(.clk(clk), .rst(rst), .d(dC), .q(qC));

    // Flip-flop for D
    xor(tD, qD, qC);                  // T-flip flop toggling based on previous bit (C)
    xor(tD_up, tD, up_down);
    and(and_enable_tD, enable, tD_up);
    xor(dD, qD, and_enable_tD);
    dff ffD(.clk(clk), .rst(rst), .d(dD), .q(qD));

    // Flip-flop for E (LSB)
    xor(tE, qE, qD);                  // T-flip flop toggling based on previous bit (D)
    xor(tE_up, tE, up_down);
    and(and_enable_tE, enable, tE_up);
    xor(dE, qE, and_enable_tE);
    dff ffE(.clk(clk), .rst(rst), .d(dE), .q(qE));

    // Output assignment
    assign A = qA;
    assign B = qB;
    assign C = qC;
    assign D = qD;
    assign E = qE;

endmodule

// D Flip-Flop module with asynchronous reset
module dff (
    input clk,      // Clock signal
    input rst,      // Reset signal
    input d,        // Data input
    output reg q    // Output of flip-flop
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;  // Reset the flip-flop output to 0
        else
            q <= d;     // Set the output to input data (D flip-flop behavior)
    end
endmodule
//1)LOW-LOW
module low_low(
    input A,
    input B,
    input C,
    input D,
    output N1,
    output N0,
    output W1,
    output W0
);

    // Intermediate wires for gates
    wire B_or_C_or_D;
    wire notB, notC, notD;
    
    // Calculate (B + C + D)
    or or1 (B_or_C_or_D, B, C, D);
    
    // Calculate NOTs for B, C, and D
    not not1 (notB, B);
    not not2 (notC, C);
    not not3 (notD, D);
    
    // Calculate N1
    and and1 (tempN1, A, B_or_C_or_D);
    not not4 (N1, tempN1);
    
    // Calculate N0
    and and2 (N0, notB, notC, notD);
    not not5 (N0, N0); // Invert the output for N0
    
    // Calculate W1
    and and3 (W1, A, B_or_C_or_D);
    
    // Calculate W0 (same as N0 in this case)
    and and4 (W0, notB, notC, notD);
    not not6 (W0, W0); // Invert the output for W0
endmodule


//2)LOW-MODERATE
module low_mod(
    input A,
    input B,
    input C,
    input D,
    input E,
    input F,
    output W1,  // East-West light (formerly N1)
    output W0,  // East-West light (formerly N0)
    output N1,  // North-South light (formerly W1)
    output N0   // North-South light (formerly W0)
);

// Intermediate signals
wire notA;
wire notB;
wire notC;
wire notD;
wire notE;
wire or1;

// Logic for East-West light (originally for North-South)
not (notA, A);
or (or1, B, C, D, E);
and (W1, notA, or1);  // Now W1 corresponds to N1
not (notB, B);
not (notC, C);
not (notD, D);
not (notE, E);
and (W0, notB, notC, notD, notE);  // Now W0 corresponds to N0

// Logic for North-South light (originally for East-West)
and (N1, A, or1);  // Now N1 corresponds to W1
and (N0, notB, notC, notD, notE);  // Now N0 corresponds to W0

endmodule


//3)LOW-HIGH
module low_high(
    input wire A, B, C, D, E, F, // Inputs
    output wire N1, N0, W1, W0   // Outputs
);

// Internal wires
wire not_A, not_B, not_C, not_D, not_E;
wire or_AB, or_ACDE, or_CDE, and_N0, and_W0, and_W1_temp, and_N1_temp;

// Negate inputs
not U1(not_A, A);
not U2(not_B, B);
not U3(not_C, C);
not U4(not_D, D);
not U5(not_E, E);

// W1 = (A + B)(A + C + D + E) (originally N1)
or  U6(or_AB, A, B);              // or_AB = A + B
or  U7(or_ACDE, A, C, D, E);      // or_ACDE = A + C + D + E
and U8(W1, or_AB, or_ACDE);       // W1 = (A + B)(A + C + D + E)

// W0 = ~A . ~C . ~D . ~E (originally N0)
and U9(and_W0, not_A, not_C, not_D, not_E);
assign W0 = and_W0;               // W0 = ~A . ~C . ~D . ~E

// N1 = ~A . ~B(C + D + E) (originally W1)
or  U10(or_CDE, C, D, E);         // or_CDE = C + D + E
and U11(and_N1_temp, not_A, not_B, or_CDE); // and_N1_temp = ~A . ~B(C + D + E)
assign N1 = and_N1_temp;          // N1 = ~A . ~B(C + D + E)

// N0 = ~A . ~C . ~D . ~E (originally W0)
assign N0 = and_W0;               // N0 = ~A . ~C . ~D . ~E

endmodule


//4)MODERATE-LOW
module mod_low(
    input A,
    input B,
    input C,
    input D,
    input E,
    input F,
    output N1,
    output N0,
    output W1,
    output W0
);

// Intermediate signals
wire notA;
wire notB;
wire notC;
wire notD;
wire notE;
wire or1;

// Logic for North-South light
not (notA, A);
or (or1, B, C, D, E);
and (N1, notA, or1);
not (notB, B);
not (notC, C);
not (notD, D);
not (notE, E);
and (N0, notB, notC, notD, notE);

// Logic for East-West light
and (W1, A, or1); // Reusing or1 for W1
and (W0, notB, notC, notD, notE); // Reusing the same not gates

endmodule

//5)MODERATE-MODERATE
module mod_mod(
    input A,
    input B,
    input C,
    input D,
    input E,
    output N1,
    output N0,
    output W1,
    output W0
);

    // Intermediate wires
    wire B_or_C_or_D_or_E;
    wire notB, notC, notD, notE;
    wire notB_and_C_and_D_and_E;
    
    // Calculate (B + C + D + E)
    or or1 (B_or_C_or_D_or_E, B, C, D, E);
    
    // Calculate NOTs for B, C, D, and E
    not not1 (notB, B);
    not not2 (notC, C);
    not not3 (notD, D);
    not not4 (notE, E);
    
    // Calculate (~B + ~C + ~D + ~E)
    wire notB_or_notC_or_notD_or_notE;
    or or2 (notB_or_notC_or_notD_or_notE, notB, notC, notD, notE);
    
    // Calculate (B.C.D.E)
    and and1 (notB_and_C_and_D_and_E, B, C, D, E);
    
    // Calculate N1
    wire tempN1;
    and and2 (tempN1, notB_or_notC_or_notD_or_notE, B_or_C_or_D_or_E);
    not not5 (N1, tempN1);
    
    // Calculate N0
    wire tempN0;
    or or3 (tempN0, (notB & notC & notD & notE), notB_and_C_and_D_and_E);
    not not6 (N0, tempN0);
    
    // Assign W1
    assign W1 = A;
    
    // Calculate W0
    wire tempW0;
    or or4 (tempW0, (notB & notC & notD & notE), notB_and_C_and_D_and_E);
    not not7 (W0, tempW0);

endmodule



//6)MODERATE-HIGH
module mod_high(
    input A, B, C, D, E, F,
    output N1, N0, W1, W0
);
    wire notA, notB, notC, notD, notE, notF;
    wire term1, term2, term3, term4, term5, term6;
    
    not (notA, A);
    not (notB, B);
    not (notC, C);
    not (notD, D);
    not (notE, E);
    not (notF, F);

    wire T1, T2, T3, T4, T5;
    
    or (T1, A, C, D, E, F);
    or (T2, A, notC, notD, notE, notF);
    or (T3, A, notB);
    or (T4, notA, B, C, D);
    or (T5, notA, B, C, E, F);

    and (N1, T1, T2, T3, T4, T5);

    wire termAB, termAC, termADE, termADF, term5, term6;
    
    and (termAB, A, B);
    and (termAC, A, C);
    and (termADE, A, D, E);
    and (termADF, A, D, F);
    and (term5, notB, C, D, E, F);
    and (term6, notA, notB, notC, notD, notE, notF);

    or (N0, termAB, termAC, termADE, termADF, term5, term6);

    or (W1, A, B);
    assign W0 = N0;

endmodule


//7)HIGH-LOW
module high_low(
    input wire A, B, C, D, E, F, // Inputs
    output wire N1, N0, W1, W0   // Outputs
);

// Internal wires
wire not_A, not_B, not_C, not_D, not_E;
wire or_AB, or_ACDE, or_CDE, and_N0, and_W0, and_W1_temp, and_N1_temp;

// Negate inputs
not U1(not_A, A);
not U2(not_B, B);
not U3(not_C, C);
not U4(not_D, D);
not U5(not_E, E);

// N1 = (A + B)(A + C + D + E)
or  U6(or_AB, A, B);              // or_AB = A + B
or  U7(or_ACDE, A, C, D, E);      // or_ACDE = A + C + D + E
and U8(N1, or_AB, or_ACDE);       // N1 = (A + B)(A + C + D + E)

// N0 = ~A . ~C . ~D . ~E
and U9(and_N0, not_A, not_C, not_D, not_E);
assign N0 = and_N0;               // N0 = ~A . ~C . ~D . ~E

// W1 = ~A . ~B(C + D + E)
or  U10(or_CDE, C, D, E);         // or_CDE = C + D + E
and U11(and_W1_temp, not_A, not_B, or_CDE); // and_W1_temp = ~A . ~B(C + D + E)
assign W1 = and_W1_temp;          // W1 = ~A . ~B(C + D + E)

// W0 = ~A . ~C . ~D . ~E (same as N0)
assign W0 = and_N0;               // W0 = ~A . ~C . ~D . ~E

endmodule


//8)HIGH MODERATE
module high_mod(
    input A, B, C, D, E, F,
    output N1, N0, W1, W0
);
    wire notA, notB, notC, notD, notE, notF;
    wire term1, term2, term3, term4, term5, term6;

    not (notA, A);
    not (notB, B);
    not (notC, C);
    not (notD, D);
    not (notE, E);
    not (notF, F);

    wire T1, T2, T3, T4, T5;

    or (T1, A, C, D, E, F);
    or (T2, A, notC, notD, notE, notF);
    or (T3, A, notB);
    or (T4, notA, B, C, D);
    or (T5, notA, B, C, E, F);

    and (N1, T1, T2, T3, T4, T5);

    wire termAB, termAC, termADE, termADF, term5, term6;

    and (termAB, A, B);
    and (termAC, A, C);
    and (termADE, A, D, E);
    and (termADF, A, D, F);
    and (term5, notB, C, D, E, F);
    and (term6, notA, notB, notC, notD, notE, notF);

    or (N0, termAB, termAC, termADE, termADF, term5, term6);

    or (W1, A, B);
    assign W0 = N0;

endmodule



//9)HIGH-HIGH
module high_high(
    input A,
    input B,
    input C,
    input D,
    input E,
    input F,
    output N1,
    output N0,
    output W1,
    output W0
);

    // Intermediate wires
    wire B_or_C_or_D_or_E_or_F;
    wire notB, notC, notD, notE, notF;
    wire notB_or_notD_or_notE;
    wire notB_or_notC;
    wire and1, and2, and3, and4;
    wire A_and_B_and_C_and_D_and_E_and_F;

    // Calculate (B + C + D + E + F)
    or or1 (B_or_C_or_D_or_E_or_F, B, C, D, E, F);
    
    // Calculate NOTs for B, C, D, E, and F
    not not1 (notB, B);
    not not2 (notC, C);
    not not3 (notD, D);
    not not4 (notE, E);
    not not5 (notF, F);
    
    // Calculate (~B + ~D + ~E)
    or or2 (notB_or_notD_or_notE, notB, notD, notE);
    
    // Calculate (~B + ~C)
    or or3 (notB_or_notC, notB, notC);
    
    // Calculate A AND B AND C AND D AND E AND F
    and and5 (A_and_B_and_C_and_D_and_E_and_F, A, B, C, D, E, F);
    
    // Calculate N1
    wire tempN1;
    and and6 (and1, B_or_C_or_D_or_E_or_F, notB_or_notD_or_notE);
    and and7 (and2, and1, notB_or_notC);
    not not6 (tempN1, A); // ~A
    and and8 (N1, and2, tempN1);
    
    // Calculate N0
    wire tempN0;
    or or4 (tempN0, A_and_B_and_C_and_D_and_E_and_F, (notB & (notC & D & notF) & notA));
    not not7 (N0, tempN0);

    // Calculate W1
    wire andBDEF, andBC, orW1;
    and and9 (andBDEF, B, D, E, F);
    and and10 (andBC, B, C);
    or or5 (orW1, andBDEF, andBC);
    or or6 (W1, orW1, A);

    // Calculate W0 (same as N0 in this case)
    or or7 (tempW0, A_and_B_and_C_and_D_and_E_and_F, (notB & (notC & D & notF) & notA));
    not not8 (W0, tempW0);

endmodule

