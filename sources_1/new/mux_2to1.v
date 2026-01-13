`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2025 13:11:20
// Design Name: 
// Module Name: mux_2to1
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


module mux_2to1(
    input        CLK,         // new clock input
    input  [3:0] IN1,
    input  [3:0] IN2,
    input  [1:0] CONTROL,     // now 2 bits for 3 operations
    output reg [3:0] OUT
    );

always @(posedge CLK) begin
    case (CONTROL)
        2'b00: OUT <= IN1;    // select IN1
        2'b01: OUT <= IN2;    // select IN2
        2'b10: OUT <= OUT;    // hold previous value
        default: OUT <= OUT;  // default hold
    endcase
end

endmodule

