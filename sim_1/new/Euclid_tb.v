`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2025 16:43:53
// Design Name: 
// Module Name: Euclid_tb
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


module Euclid_tb(

    );
    
reg clk;
reg reset;
reg [3:0] s_0;
reg [3:0] s_1;
reg [3:0] s_2;
reg [3:0] s_3;
reg START;

wire [3:0] lambda_0;
wire [3:0] lambda_1;
wire [3:0] lambda_2;

wire [3:0] omega_0;
wire [3:0] omega_1;

Euclid uut(
        .CLK(clk),
        .RESET(reset),
        .S_0(s_0),
        .S_1(s_1),
        .S_2(s_2),
        .S_3(s_3),
        .START(START),
        .LAMBDA_0(lambda_0),
        .LAMBDA_1(lambda_1),
        .LAMBDA_2(lambda_2),
        .OMEGA_0(omega_0),
        .OMEGA_1(omega_1)
        );

initial begin
    clk = 0;
    reset = 1;
    #10;
    reset = 0;
    #10;
    forever begin
        #10;
        clk = ~clk;
    end
end

initial begin
    START = 0;
    s_0 = 0;
    s_1 = 0;
    s_2 = 0;
    s_3 = 0;
    #50;
    START = 1;
    s_0 = 15;
    s_1 = 3;
    s_2 = 4;
    s_3 = 12;
    #10;
    START = 0;
    #130;
    s_0 = 0;
    s_1 = 0;
    s_2 = 0;
    s_3 = 0;
end
endmodule
