`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.12.2025 14:33:37
// Design Name: 
// Module Name: lambda_divider
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


module lambda_divider(
    input [3:0] Omega_0,
    input [3:0] Omega_1,
    input [3:0] Gamma_0,
    input [3:0] Gamma_1,
    input [3:0] Gamma_2,
    input CLK,
    output [3:0] div_Omega_0,
    output [3:0] div_Omega_1,
    output [3:0] div_Gamma_0,
    output [3:0] div_Gamma_1,
    output [3:0] div_Gamma_2
    );
    
    integer i;
    
    wire [3:0] inv_lambda;
    
    //inversion
    GF_inverse INV(
        .IN(Gamma_0),
        .OUT(inv_lambda)
        );
    
    //multiply by inverted
    
    //full multiplier
    full_GF_mult mult_Omega_0(
        .A(Omega_0),
        .B(inv_lambda),
        .out(div_Omega_0)
        );
        
    full_GF_mult mult_Omega_1(
        .A(Omega_1),
        .B(inv_lambda),
        .out(div_Omega_1)
        );
                
    full_GF_mult mult_Gamma_0(
        .A(Gamma_0),
        .B(inv_lambda),
        .out(div_Gamma_0)
        );
                        
    full_GF_mult mult_Gamma_1(
        .A(Gamma_1),
        .B(inv_lambda),
        .out(div_Gamma_1)
        );
                                
    full_GF_mult mult_Gamma_2(
        .A(Gamma_2),
        .B(inv_lambda),
        .out(div_Gamma_2)
        );

endmodule
