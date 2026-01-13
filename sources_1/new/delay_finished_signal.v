`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2026 16:49:29
// Design Name: 
// Module Name: delay_finished_signal
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


module delay_finished_signal (
    input  wire CLK,
    input  wire RESET,
    input  wire [3:0] finished_in,
    output wire [3:0] finished_out
);
    
    // 56-stage shift register (56 * 4 = 224 bits)
    reg [223:0] shift_reg;  // One extra stage = 4 extra bits
    
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            shift_reg <= 224'b0;
        end else begin
            // Shift left by 4 bits, insert new data
            shift_reg <= {shift_reg[219:0], finished_in};
        end
    end
    
    // Output is from stage 56 (bits 223:220) instead of stage 55
    assign finished_out = shift_reg[223:220];
    
endmodule