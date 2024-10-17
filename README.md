# S1-T9-TraCCS

<!-- First Section -->
## Team Details
<details>
  <summary>Detail</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S1

  > Team ID: T9

  > Member-1: Dhruv Sandilya, 231CS122, dhruvsandilya.231cs122@nitk.edu.in

  > Member-2: Sai Samanyu K, 231CS152, saisamanyukulakarni.231cs152@nitk.edu.in

  > Member-3: Vrishank Honnavalli, 231CS165, vrishanksh.231cs165@nitk.edu.in
</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>Detail</summary>
  
>1. Motivation: In today’s world the traffic congestion problems are increasing exponentially.
Not only does this cause delays to the people driving it also delays the pedestrians and also
puts their safety at risk trying to navigate the busy intersections. It is imperative to have
a model that controls the traffic flow to ensure a safe and smooth transit for all the people,
which is why we have come up with TraCCS (Traffic Control and Coordination System).
>2. Problem Statement: The fixed-timing signals used today fail to adapt to fluctuating traffic
volumes throughout the day, leading to bottlenecks at busy intersections. In this project we
are going to implement a traffic light controller that controls crossroads consisting of a main
road (East-West) and an intersecting side road (North-South).
>3. Features:
>
>>• Adaptive Signal Control: Manually adjusting traffic light timings based on real-time
traffic conditions. This reduces wait times, prevents congestion, and optimizes traffic
flow.
>>
>>• Energy Efficiency: Integration of the the traffic light control system with clean, renew-
able solar energy to power the LED’s during daytime with a backup power source.
</details>

## Functional Block Diagram
<details>
  <summary>Detail</summary>
  

<img width="322" alt="S1-T9-TraCCS drawio" src="https://github.com/user-attachments/assets/d0bde9d9-4529-44f8-8c50-f18416734141">
</details>

<!-- Third Section -->
## Working
<details>
  <summary>Detail</summary>

  > The 4-way traffic light controller operates in a cyclic sequence to manage traffic for both North-South (NS) and East-West (EW) directions, adjusting the green light duration based on traffic conditions.

>>Reset: The system starts by resetting, ensuring all lights are in their initial states—NS or EW red.

>>Traffic Condition Detection: Based on the inputs for traffic conditions (low, moderate, high) for both NS and EW, the system determines the duration of the green light for each direction. There are nine possible combinations of traffic, from low-low to high-high.

>>NS Green: The NS traffic light turns green for a duration corresponding to the traffic (7 units for low, 14 for moderate, and 21 for high). The EW light remains red during this period.

>>NS Yellow: After the green light, NS turns yellow for 1 unit of time.

>>EW Green: Next, the EW light turns green, with a duration based on the EW traffic condition, while NS remains red.

>>EW Yellow: The EW light turns yellow for 1 unit before switching back to red.

>>Cycle Repeats: The process repeats, adjusting the green light duration for each direction according to the real-time traffic conditions.

>>NOTE : For an invalid input we feeded the system to take the M-M, Moderate-Moderate Value of Traffic.
</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>
  <details>
  <summary>TraCCS Main Circuit Module</summary>

  > ![MAIN](https://github.com/user-attachments/assets/3f7d2c50-fc73-4be7-aa55-b65db5513329)
</details>
<details>
  <summary>Sub-Modules of TraCCS</summary>
<details>
  <summary>Low traffic-Low traffic Module</summary>

  > ![low-low](https://github.com/user-attachments/assets/7e7a4ce4-b692-4e2d-b4dc-f478c0dfee2f)
</details>
<details>
  <summary>Low traffic-Moderate traffic Module</summary>

  > ![low mod](https://github.com/user-attachments/assets/c91771e5-921c-4766-aeb0-0385b18526e9)
</details>
<details>
  <summary>Low traffic-High traffic Module</summary>

  > ![low high](https://github.com/user-attachments/assets/505beb3d-dbd8-4662-af7b-6ab8073bca21)
</details>
<details>
  <summary>Moderate traffic-Low traffic Module</summary>

  > ![mod low](https://github.com/user-attachments/assets/6fda2c38-1cc5-4e33-8574-ba02887d9e18)
</details>
<details>
  <summary>Moderate traffic-Moderate traffic Module</summary>

  > ![mod-mod](https://github.com/user-attachments/assets/8508e5e6-9be2-4f6d-92fb-802988d1a3e4)
</details>
<details>
  <summary>Moderate traffic-High traffic Module</summary>

  > ![mod high](https://github.com/user-attachments/assets/e7f8340a-4802-4d41-9e74-507d1b16b459)
</details>
<details>
  <summary>High traffic-Low traffic Module</summary>

  > ![high low](https://github.com/user-attachments/assets/8974006f-f2fd-4d94-9a33-8c946101d428)
</details>
<details>
  <summary>High traffic-Moderate traffic Module</summary>

  > ![high mod](https://github.com/user-attachments/assets/e4ddd57a-2c44-4852-9863-58a622dcd5b7)
</details>
<details>
  <summary>High traffic-High traffic Module</summary>

  > ![high-high](https://github.com/user-attachments/assets/02c1dd60-a5e8-46cd-a522-420773413ea7)
</details>
<details>
  <summary>Traffic Selector Module</summary>

  > ![traffic selector](https://github.com/user-attachments/assets/9973aa5c-8b99-4c18-9d92-50003fd2a39f)
</details>
</details>
</details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>
```verilog
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
    wire and_enable_tA, and_enable_tB, and_enable_tC, and_enable_tD, and_enable_tE; // AND gates for enable and T-flip          control

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



</details>

## References
<details>
  <summary>Detail</summary>
  
> Digital Design *M. Morris Mano, Michael D. Ciletti*
> 
  >[(Digital Design PDF)](http://surl.li/avkgxx)
>
> NOC *Hardware modeling using verilog, IIT Kharagpur*
> 
   >[(NPTEL Lectures)](https://nptel.ac.in/courses/106/105/106105165/)
>
> 555 Timer IC : Types, Construction, Working & Application
> 
   >[(555 Timer IC)](https://www.electricaltechnology.org/2014/12/555-timer.html)
> 
> Four Way Traffic Lights Circuit using 555 Timer IC
> 
   >[(www.circuitdigest.com/)](https://circuitdigest.com/electronic-circuits/four-way-traffic-light-circuit)
>
> Four Way Traffic Light Circuit
> 
   >[(www.circuits-diy.com)](https://www.circuits-diy.com/four-way-traffic-light-circuit/)
   
</details>
