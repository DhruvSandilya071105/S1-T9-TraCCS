module traffic_light_controller(
    input wire clk,  // Clock input
    input wire rst,  // Reset input
    input wire [1:0] traffic_NS,  // Traffic condition for North-South (00 = low, 01 = moderate, 10 = high)
    input wire [1:0] traffic_EW,  // Traffic condition for East-West (00 = low, 01 = moderate, 10 = high)
    output reg [1:0] NS_light,    // 2-bit light for North-South (00 = red, 01 = yellow, 10 = green)
    output reg [1:0] EW_light     // 2-bit light for East-West (00 = red, 01 = yellow, 10 = green)
);

// Traffic conditions
localparam LOW = 2'b00;
localparam MODERATE = 2'b01;
localparam HIGH = 2'b10;

// Timing parameters (assuming units of time as clock cycles)
localparam LOW_GREEN = 7;
localparam MOD_GREEN = 14;
localparam HIGH_GREEN = 21;
localparam YELLOW_TIME = 1;

// State definitions
localparam RED = 2'b00;
localparam YELLOW = 2'b01;
localparam GREEN = 2'b10;

reg [4:0] counter;  // Counter to manage timing
reg [1:0] state;  // 00 = NS green, EW red; 01 = NS yellow, EW red; 10 = NS red, EW green; 11 = NS red, EW yellow

always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset the system
        counter <= 0;
        state <= 2'b00;
        NS_light <= GREEN;
        EW_light <= RED;
    end else begin
        case (state)
            2'b00: begin  // NS green, EW red
                case (traffic_NS)
                    LOW: if (counter < LOW_GREEN) counter <= counter + 1;
                    MODERATE: if (counter < MOD_GREEN) counter <= counter + 1;
                    HIGH: if (counter < HIGH_GREEN) counter <= counter + 1;
                endcase
                if ((traffic_NS == LOW && counter == LOW_GREEN) ||
                    (traffic_NS == MODERATE && counter == MOD_GREEN) ||
                    (traffic_NS == HIGH && counter == HIGH_GREEN)) begin
                    NS_light <= YELLOW;  // Transition to yellow
                    EW_light <= RED;
                    counter <= 0;
                    state <= 2'b01;
                end
            end
            
            2'b01: begin  // NS yellow, EW red
                if (counter < YELLOW_TIME) counter <= counter + 1;
                else begin
                    NS_light <= RED;
                    EW_light <= GREEN;
                    counter <= 0;
                    state <= 2'b10;
                end
            end
            
            2'b10: begin  // NS red, EW green
                case (traffic_EW)
                    LOW: if (counter < LOW_GREEN) counter <= counter + 1;
                    MODERATE: if (counter < MOD_GREEN) counter <= counter + 1;
                    HIGH: if (counter < HIGH_GREEN) counter <= counter + 1;
                endcase
                if ((traffic_EW == LOW && counter == LOW_GREEN) ||
                    (traffic_EW == MODERATE && counter == MOD_GREEN) ||
                    (traffic_EW == HIGH && counter == HIGH_GREEN)) begin
                    EW_light <= YELLOW;  // Transition to yellow
                    counter <= 0;
                    state <= 2'b11;
                end
            end
            
            2'b11: begin  // NS red, EW yellow
                if (counter < YELLOW_TIME) counter <= counter + 1;
                else begin
                    EW_light <= RED;
                    NS_light <= GREEN;
                    counter <= 0;
                    state <= 2'b00;
                end
            end
        endcase
    end
end

endmodule

