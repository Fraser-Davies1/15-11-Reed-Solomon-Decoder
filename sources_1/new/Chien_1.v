`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 10:48:17
// Design Name: 
// Module Name: Chien_0
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


module Chien_1(
    input [3:0] Gamma_0,
    input CLK,
    input RESET,
    input CONTROL,
    output reg [3:0] Chien_0
    );
    
parameter alpha_0 = 1;
wire [3:0] IN_0;
wire [3:0] Mult_out;
    

assign IN_0 = CONTROL ? Gamma_0 : Chien_0;
       
full_GF_mult mult_Chien_0 (
    .A(IN_0),
    .B(alpha_0),
    .out(Mult_out)
    ); 
    
always@(posedge CLK or posedge RESET) begin
    if(RESET)
        Chien_0 <= 0;
    else
        Chien_0 <= Mult_out;
end  

endmodule
