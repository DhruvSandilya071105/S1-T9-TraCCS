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
  
 ![TraCCS-Block Diagram](https://github.com/user-attachments/assets/9c12f025-2745-4744-ad9d-3793e24c3e86)

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

  > 
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
