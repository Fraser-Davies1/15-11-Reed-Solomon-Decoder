`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 10:35:58
// Design Name: 
// Module Name: Error_Positioning
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


module Error_Positioning(
    input [3:0] Omega_0,
    input [3:0] Omega_1,
    input [3:0] Gamma_0,
    input [3:0] Gamma_1,
    input [3:0] Gamma_2,
    input CLK,
    input CONTROL,
    input RESET,
    output [3:0] error_values
    );
    
wire [3:0] root_0;
wire [3:0] root_1;
wire [3:0] root_2;
wire [3:0] root_3;
wire [3:0] root_4;
wire [3:0] deriv_plus_const;
wire [3:0] zero_detector;
wire [3:0] deriv;
wire [3:0] Omega_root;
wire [3:0] inv_deriv;
wire [3:0] Mult_out;
wire [3:0] pos;
    
Chien_1 Chien_mult_0(
        .Gamma_0(Gamma_0),
        .CLK(CLK),
        .RESET(RESET),
        .CONTROL(CONTROL),
        .Chien_0(root_0)
        );
        
Chien_2 Chien_mult_1(
        .Gamma_1(Gamma_1),
        .CLK(CLK),
        .RESET(RESET),
        .CONTROL(CONTROL),
        .Chien_1(root_1)
        );

Chien_3 Chien_mult_2(
        .Gamma_2(Gamma_2),
        .CLK(CLK),
        .RESET(RESET),
        .CONTROL(CONTROL),
        .Chien_2(root_2)
        );
        
GF_ADDER deriv_plus_c(
        .IN1(root_0),
        .IN2(root_1),
        .OUT(deriv_plus_const)
        );

GF_ADDER error_position(
        .IN1(deriv_plus_const),
        .IN2(root_2),
        .OUT(zero_detector)
        );
        
Chien_1 Forney_mult_0(
        .Gamma_0(Omega_0),
        .CLK(CLK),
        .RESET(RESET),
        .CONTROL(CONTROL),
        .Chien_0(root_3)
        );
Chien_2 Forney_mult_1(
        .Gamma_1(Omega_1),
        .CLK(CLK),
        .RESET(RESET),
        .CONTROL(CONTROL),
        .Chien_1(root_4)
        );
 
        
// if a zero is detected, set position bit to high
assign pos = (zero_detector == 4'b0000) ? 4'b1111:4'b0000;

assign deriv = root_1;

GF_ADDER Omega_roots(
        .IN1(root_3),
        .IN2(root_4),
        .OUT(Omega_root)
        );
        
full_GF_mult mult_error_val (
        .A(Omega_root),
        .B(inv_deriv),
        .out(Mult_out)
        ); 
        
GF_inverse deriv_inverter(
        .IN(deriv),
        .OUT(inv_deriv)
        );
        
assign error_values = Mult_out & pos;

endmodule
