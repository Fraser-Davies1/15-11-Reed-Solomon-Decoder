`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2025 13:08:44
// Design Name: 
// Module Name: Euclid_div_sect
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


module Euclid_div_sect(
    input [3:0] syndrome0,
    input [3:0] syndrome1,
    input [3:0] syndrome2,
    input [3:0] syndrome3,
    input CLK,
    input RESET,
    input [4:0] CONTROL,
    output [3:0] OUT,
    output [3:0] omega1,
    output [3:0] omega0,
    output degree
    );
    
    
wire [3:0] MUX_A0_OUT;
wire [3:0] MUX_A1_OUT;
wire [3:0] MUX_A2_OUT;
wire [3:0] MUX_A3_OUT;

wire [3:0] MUX_B0_OUT;
wire [3:0] MUX_B1_OUT;
wire [3:0] MUX_B2_OUT;
wire [3:0] MUX_B3_OUT;

wire [3:0] A0_OUT;
wire [3:0] A1_OUT;
wire [3:0] A2_OUT;
wire [3:0] A3_OUT;

wire [3:0] B0_OUT;
wire [3:0] B1_OUT;
wire [3:0] B2_OUT;
wire [3:0] B3_OUT;

wire [3:0] INV_OUT;

wire [3:0] FDBK_0;
wire [3:0] FDBK_1;
wire [3:0] FDBK_2;

wire [3:0] mult_A0_out;
wire [3:0] mult_A1_out;
wire [3:0] mult_A2_out;
wire [3:0] mult_A3_out;


// input MUXs
mux_3to1 MUX_A0(
    .IN1(0),
    .IN2(syndrome0),
    .IN3(A0_OUT),
    .CONTROL(CONTROL[3:2]),
    .OUT(MUX_A0_OUT)
    );
mux_3to1 MUX_A1(
    .IN1(FDBK_0),
    .IN2(syndrome1),
    .IN3(A1_OUT),
    .CONTROL(CONTROL[3:2]),
    .OUT(MUX_A1_OUT)
    );
mux_3to1 MUX_A2(
    .IN1(FDBK_1),
    .IN2(syndrome2),
    .IN3(A2_OUT),
    .CONTROL(CONTROL[3:2]),
    .OUT(MUX_A2_OUT)
    );
mux_3to1 MUX_A3(
    .IN1(FDBK_2),
    .IN2(syndrome3),
    .IN3(A3_OUT),
    .CONTROL(CONTROL[3:2]),
    .OUT(MUX_A3_OUT)
    );

// A registers
DFF_4 A0 (
            .CLK(CLK),
            .D(MUX_A0_OUT),
            .Q(A0_OUT),
            .RESET(RESET)
            );
DFF_4 A1 (
            .CLK(CLK),
            .D(MUX_A1_OUT),
            .Q(A1_OUT),
            .RESET(RESET)
            );
DFF_4 A2 (
            .CLK(CLK),
            .D(MUX_A2_OUT),
            .Q(A2_OUT),
            .RESET(RESET)
            );
DFF_4 A3 (
            .CLK(CLK),
            .D(MUX_A3_OUT),
            .Q(A3_OUT),
            .RESET(RESET)
            );
            


//full multipliers
full_GF_mult mult_A0 (
    .A(A0_OUT),
    .B(mult_A3_out),
    .out(mult_A0_out)
    );
full_GF_mult mult_A1 (
    .A(A1_OUT),
    .B(mult_A3_out),
    .out(mult_A1_out)
    );
full_GF_mult mult_A2 (
    .A(A2_OUT),
    .B(mult_A3_out),
    .out(mult_A2_out)
    );

GF_inverse INV(
    .IN(A3_OUT),
    .OUT(INV_OUT)
    );
    
full_GF_mult mult_A3 (
    .A(INV_OUT),
    .B(B3_OUT),
    .out(mult_A3_out)
    );
    
//B registers
DFF_4 B0 (
            .CLK(CLK),
            .D(MUX_B0_OUT),
            .Q(B0_OUT),
            .RESET(RESET)
            );
DFF_4 B1 (
            .CLK(CLK),
            .D(MUX_B1_OUT),
            .Q(B1_OUT),
            .RESET(RESET)
            );
DFF_4 B2 (
            .CLK(CLK),
            .D(MUX_B2_OUT),
            .Q(B2_OUT),
            .RESET(RESET)
            );
DFF_4 B3 (
            .CLK(CLK),
            .D(MUX_B3_OUT),
            .Q(B3_OUT),
            .RESET(RESET)
            );

// B input MUXs
mux_3to1 MUX_B0(
    .IN1(0),
    .IN2(A0_OUT),
    .IN3(0),
    .CONTROL(CONTROL[1:0]),
    .OUT(MUX_B0_OUT)
    );
mux_3to1 MUX_B1(
    .IN1(FDBK_0),
    .IN2(A1_OUT),
    .IN3(0),
    .CONTROL(CONTROL[1:0]),
    .OUT(MUX_B1_OUT)
    );
mux_3to1 MUX_B2(
    .IN1(FDBK_1),
    .IN2(A2_OUT),
    .IN3(0),
    .CONTROL(CONTROL[1:0]),
    .OUT(MUX_B2_OUT)
    );
mux_3to1 MUX_B3(
    .IN1(FDBK_2),
    .IN2(A3_OUT),
    .IN3(1),
    .CONTROL(CONTROL[1:0]),
    .OUT(MUX_B3_OUT)
    );

//B register adders 
GF_ADDER ADD0(
        .IN1(B0_OUT),
        .IN2(mult_A0_out),
        .OUT(FDBK_0)
        );
GF_ADDER ADD1(
        .IN1(B1_OUT),
        .IN2(mult_A1_out),
        .OUT(FDBK_1)
        );
GF_ADDER ADD2(
        .IN1(B2_OUT),
        .IN2(mult_A2_out),
        .OUT(FDBK_2)
        );
        
        
wire [1:0] deg_A, deg_B;
wire zero_A, zero_B;

poly_degree_4 DEG_A (
    .A3(A0_OUT), .A2(A1_OUT), .A1(A2_OUT), .A0(A3_OUT),
    .deg(deg_A),
    .is_zero(zero_A)
);



wire degree_cond;
reg  degree_cond_d;
reg  degree_pulse;

assign degree_cond = (deg_A < 2);

// check if degree of polynomial < 2 then send one clock long pulse to
// next subsystem to say euclid is done
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        degree_cond_d <= 1'b0;
        degree_pulse  <= 1'b0;
    end else begin
        degree_cond_d <= degree_cond;
        degree_pulse  <= degree_cond & ~degree_cond_d;
    end
end

assign degree = degree_pulse;




assign omega1 = FDBK_2;
assign omega0 = FDBK_1;
assign OUT = mult_A3_out;
endmodule
