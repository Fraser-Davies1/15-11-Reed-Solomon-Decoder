`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2025 12:49:59
// Design Name: 
// Module Name: GF_inverse
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


module GF_inverse(
    input [3:0] IN,
    output reg [3:0] OUT
    );

always@ (IN) begin  
    case(IN)
        0: OUT <= 0;
        1: OUT <= 1;
        2: OUT <= 9;
        3: OUT <= 14;
        4: OUT <= 13;
        5: OUT <= 11;
        6: OUT <= 7;
        7: OUT <= 6;
        8: OUT <= 15;
        9: OUT <= 2;
        10: OUT <= 12;
        11: OUT <= 5;
        12: OUT <= 10;
        13: OUT <= 4;
        14: OUT <= 3;
        15: OUT <= 8;
    endcase
end
endmodule
