`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2025 17:30:37
// Design Name: 
// Module Name: syndrome_3
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


module syndrome_2(
    input [3:0] IN_SERIAL,
    input [3:0] CONTROL,
    input CLK,
    input RESET_GLOBAL,
    output [3:0] OUT_SERIAL
    );
    
wire [3:0] MULT_OUT;
wire [3:0] DFF_OUT;
wire [3:0] FDBK_LOOP;
wire [3:0] FDBK_ADDED;
wire [3:0] CONTROL_OUT = DFF_OUT & CONTROL;

    
DFF_4 DFF(
        .CLK(CLK),
        .D(FDBK_ADDED),
        .Q(DFF_OUT),
        .RESET(RESET_GLOBAL)
        );
        
GF_2_multiplier MULT2 (
                        .IN(FDBK_LOOP),
                        .OUT(FDBK_ADDED)
                        );
        
GF_ADDER ADDER(
        .IN1(IN_SERIAL),
        .IN2(CONTROL_OUT),
        .OUT(FDBK_LOOP)
        );

assign OUT_SERIAL = FDBK_LOOP;

endmodule
