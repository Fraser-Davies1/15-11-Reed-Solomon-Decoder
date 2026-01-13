`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2025 12:12:43
// Design Name: 
// Module Name: Euclid_mult_sect
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


module Euclid_mult_sect(
    input [3:0] div_res,
    input CLK,
    input RESET,
    input [4:0] CONTROL,
    input shift,
    output [3:0] lambda0,
    output [3:0] lambda1,
    output [3:0] lambda2
    );
    
    
    
    
wire [3:0] C0_OUT;
wire [3:0] C1_OUT;


wire [3:0] D0_OUT;
wire [3:0] D1_OUT;
wire [3:0] D2_OUT;

wire [3:0] MUX_C0_OUT;
wire [3:0] MUX_C1_OUT;

wire [3:0] MUX_D0_OUT;
wire [3:0] MUX_D1_OUT;
wire [3:0] MUX_D2_OUT;

wire [3:0] mult_C0_out;
wire [3:0] mult_C1_out;

wire [3:0] A;
wire [3:0] B;
wire [3:0] C;

wire [3:0] FDBK_0;
wire [3:0] FDBK_1;
wire [3:0] FDBK_2;

    
// C input MUXs
mux_3to1 MUX_C0(
    .IN1(FDBK_0),
    .IN2(1),
    .IN3(C0_OUT),
    .CONTROL(CONTROL[3:2]),
    .OUT(MUX_C0_OUT)
    );
mux_3to1 MUX_C1(
    .IN1(FDBK_1),
    .IN2(0),
    .IN3(C1_OUT),
    .CONTROL(CONTROL[3:2]),
    .OUT(MUX_C1_OUT)
    );
    
// D input MUXs
mux_3to1 MUX_D0(
    .IN1(FDBK_0),
    .IN2(C0_OUT),
    .IN3(0),
    .CONTROL(CONTROL[1:0]),
    .OUT(MUX_D0_OUT)
    );
mux_3to1 MUX_D1(
    .IN1(FDBK_1),
    .IN2(C1_OUT),
    .IN3(0),
    .CONTROL(CONTROL[1:0]),
    .OUT(MUX_D1_OUT)
    );
mux_3to1 MUX_D2(
    .IN1(FDBK_2),
    .IN2(0),
    .IN3(0),
    .CONTROL(CONTROL[1:0]),
    .OUT(MUX_D2_OUT)
    );
    
//D registers
DFF_4 D0 (
    .CLK(CLK),
    .D(MUX_D0_OUT),
    .Q(D0_OUT),
    .RESET(RESET)
    );
DFF_4 D1 (
    .CLK(CLK),
    .D(MUX_D1_OUT),
    .Q(D1_OUT),
    .RESET(RESET)
    );
DFF_4 D2 (
    .CLK(CLK),
    .D(MUX_D2_OUT),
    .Q(D2_OUT),
    .RESET(RESET)
    );
    
// Cregisters
DFF_4 C0 (
    .CLK(CLK),
    .D(MUX_C0_OUT),
    .Q(C0_OUT),
    .RESET(RESET)
    );
DFF_4 C1 (
    .CLK(CLK),
    .D(MUX_C1_OUT),
    .Q(C1_OUT),
    .RESET(RESET)
    );
    
//full multipliers
full_GF_mult mult_A0 (
    .A(C0_OUT),
    .B(div_res),
    .out(mult_C0_out)
    );
full_GF_mult mult_A1 (
    .A(C1_OUT),
    .B(div_res),
    .out(mult_C1_out)
    );
    
   

Shift_reg shift_controller(
    .CLK(CLK),
    .RESET(RESET),
    .CONTROL(CONTROL[4]),
    .x(mult_C0_out),
    .y(mult_C1_out),
    .a(A),
    .b(B),
    .c(C)
    );


GF_ADDER ADD3(
    .IN1(D0_OUT),
    .IN2(A),
    .OUT(FDBK_0)
    );
GF_ADDER ADD4(
    .IN1(D1_OUT),
    .IN2(B),
    .OUT(FDBK_1)
    );
GF_ADDER ADD5(
    .IN1(D2_OUT),
    .IN2(C),
    .OUT(FDBK_2)
    );

assign lambda0 = FDBK_0;
assign lambda1 = FDBK_1;
assign lambda2 = FDBK_2;

endmodule
