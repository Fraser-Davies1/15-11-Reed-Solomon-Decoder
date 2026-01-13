`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 11:16:26
// Design Name: 
// Module Name: Chien_3
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

module Chien_3(
    input [3:0] Gamma_2,
    input CLK,
    input RESET,
    input CONTROL,
    output reg [3:0] Chien_2
    );
    
parameter alpha_2 = 4;
wire [3:0] IN_2;
wire [3:0] Mult_out;
    

assign IN_2 = CONTROL ? Gamma_2 : Chien_2;
       
full_GF_mult mult_Chien_2 (
    .A(IN_2),
    .B(alpha_2),
    .out(Mult_out)
    ); 
    
always@(posedge CLK or posedge RESET) begin
    if(RESET)
        Chien_2 <= 0;
    else
        Chien_2 <= Mult_out;
end  

endmodule
