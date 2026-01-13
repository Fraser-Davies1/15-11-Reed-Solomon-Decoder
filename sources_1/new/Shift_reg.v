`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2025 12:25:48
// Design Name: 
// Module Name: Shift_reg
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


module Shift_reg( input CLK,
    input RESET,
    input CONTROL,
    input [3:0] x,
    input [3:0] y,
    output  [3:0] a,
    output  [3:0] b,
    output  [3:0] c );
       
       
        
        
    assign a = CONTROL ? x : 4'b0000;
    assign b = CONTROL ? y : x;
    assign c = CONTROL ? 4'b0000 : y; 
          
          
         
endmodule

