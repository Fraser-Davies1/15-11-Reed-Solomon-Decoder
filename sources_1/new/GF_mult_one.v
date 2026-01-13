`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2025 13:16:12
// Design Name: 
// Module Name: GF_mult_one
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


module GF_mult_one(
    input [3:0] IN,
    output reg [3:0] OUT
    );

always@(IN) begin
    case(IN)
        0:
            OUT <= 0;
        1:
            OUT <= 1;
        2:
            OUT <= 2;
        3:
            OUT <= 3;
        4:
            OUT <= 4;
        5:
            OUT <= 5;
        6:
            OUT <= 6;
        7:
            OUT <= 7;
        8:
            OUT <= 8;
        9:
            OUT <= 9;
        10:
            OUT <= 10;
        11:
            OUT <= 11;
        12:
            OUT <= 12;
        13:
            OUT <= 13;
        14:
            OUT <= 14;
        15:
            OUT <= 15;
        endcase
    end

endmodule
