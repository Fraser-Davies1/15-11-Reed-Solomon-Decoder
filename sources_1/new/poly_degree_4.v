`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2025 16:50:46
// Design Name: 
// Module Name: poly_degree_4
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


module poly_degree_4 (
    input  wire [3:0] A3, A2, A1, A0,  // 4-bit GF elements per coefficient
    output reg  [1:0] deg,             // 2-bit degree output (0-3)
    output reg        is_zero          // flag if polynomial = 0
);
    always @(*) begin
        if (A3 != 4'b0000) begin
            deg = 2'd3;
            is_zero = 1'b0;
        end else if (A2 != 4'b0000) begin
            deg = 2'd2;
            is_zero = 1'b0;
        end else if (A1 != 4'b0000) begin
            deg = 2'd1;
            is_zero = 1'b0;
        end else if (A0 != 4'b0000) begin
            deg = 2'd0;
            is_zero = 1'b0;
        end else begin
            deg = 2'd0;  // default
            is_zero = 1'b1;
        end
    end
endmodule

