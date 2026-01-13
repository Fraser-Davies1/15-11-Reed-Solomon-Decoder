`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2025 13:19:22
// Design Name: 
// Module Name: control_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_machine(
    input CLK,
    input RESET,
    output [3:0] CONTROL,
    output [3:0] COUNT_out
    );
    
wire [3:0] COUNT;
    
counter counter(
                .CLK(CLK),
                .RESET(RESET),
                .COUNT(COUNT)
                );
control control(
                .CLK(CLK),
                .RESET(RESET),
                .COUNT(COUNT),
                .CONTROL(CONTROL)
                );
                
assign COUNT_out = COUNT;
endmodule
