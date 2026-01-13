`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 11:14:31
// Design Name: 
// Module Name: Chien_2
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




module Chien_2(
    input [3:0] Gamma_1,
    input CLK,
    input RESET,
    input CONTROL,
    output reg [3:0] Chien_1
    );
    
parameter alpha_1 = 2;
wire [3:0] IN_1;
wire [3:0] Mult_out;
    

assign IN_1 = CONTROL ? Gamma_1 : Chien_1;
       
full_GF_mult mult_Chien_1 (
    .A(IN_1),
    .B(alpha_1),
    .out(Mult_out)
    ); 
    
always@(posedge CLK or posedge RESET) begin
    if(RESET)
        Chien_1 <= 0;
    else
        Chien_1 <= Mult_out;
end  

endmodule
