module traffic_light_tb();

// Testbench signals
reg clk;
reg rst;
reg [1:0] traffic_NS;  // Traffic condition for North-South
reg [1:0] traffic_EW;  // Traffic condition for East-West
wire [1:0] NS_light;   // Output light for North-South
wire [1:0] EW_light;   // Output light for East-West

// Instantiate the traffic light controller module
traffic_light_controller uut (
    .clk(clk),
    .rst(rst),
    .traffic_NS(traffic_NS),
    .traffic_EW(traffic_EW),
    .NS_light(NS_light),
    .EW_light(EW_light)
);

always begin
    clk=0;
    
    forever #5 clk = ~clk;
end

initial begin
    rst = 1;
    #10 rst = 0; 

    // Test Case 1: Low Traffic on both North-South and East-West
    traffic_NS = 2'b00; 
    traffic_EW = 2'b00;  // Both Low
    #200;

    // Test Case 2: Moderate Traffic on North-South, Low Traffic on East-West
    traffic_NS = 2'b01; 
    traffic_EW = 2'b00;  // NS Moderate, EW Low
    #200;

    // Test Case 3: High Traffic on North-South, Low Traffic on East-West
    traffic_NS = 2'b10; 
    traffic_EW = 2'b00;  // NS High, EW Low
    #300;

    // Test Case 4: Low Traffic on North-South, Moderate Traffic on East-West
    traffic_NS = 2'b00; 
    traffic_EW = 2'b01;  // NS Low, EW Moderate
    #200;
    // Test Case 5: Low Traffic on North-South, High Traffic on East-West
    traffic_NS = 2'b00;
    traffic_EW = 2'b10;  // NS Low, EW High
    #300;

    // Test Case 6: High Traffic on both North-South and East-West
    traffic_NS = 2'b10; 
    traffic_EW = 2'b10;  // Both High
    #400;

    // Test Case 7: Moderate Traffic on both North-South and East-West
    traffic_NS = 2'b01; 
    traffic_EW = 2'b01;  // Both Moderate
    #300;

    // Test Case 8: Reset the system and restart
    rst = 1;  // Activate reset
    #10 rst = 0;  // Release reset
    traffic_NS = 2'b00; 
    traffic_EW = 2'b00;  // Restart with low traffic
    #200;


    $stop;  // End simulation
end

initial begin
    $monitor("At time %t: NS_light = %b, EW_light = %b, traffic_NS = %b, traffic_EW = %b", 
             $time, NS_light, EW_light, traffic_NS, traffic_EW);
end

endmodule