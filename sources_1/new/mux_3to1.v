`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2025 13:14:23
// Design Name: 
// Module Name: mux_3to1
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


module mux_3to1(
    input [3:0] IN1,
    input [3:0] IN2,
    input [3:0] IN3,
    input [1:0] CONTROL,
    output reg [3:0] OUT
    );
   
always@(CONTROL or IN3 or IN1 or IN2) begin
    case(CONTROL)
        0: OUT <= IN1;
        1: OUT <= IN2;
        2: OUT <= IN3;
        default:
            OUT <= IN1;
    endcase
end 

endmodule
