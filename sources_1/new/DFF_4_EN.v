`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2025 11:38:13
// Design Name: 
// Module Name: DFF_4_EN
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


module DFF_4_EN(
    input CLK,
    input [3:0] D,
    input RESET,
    input [1:0] EN,
    output reg [3:0] Q
    );
    
always@(posedge CLK) begin
    if(RESET) begin
        Q <= 0;
    end
    else if (EN) begin
        Q <= D;
    end
end
endmodule
