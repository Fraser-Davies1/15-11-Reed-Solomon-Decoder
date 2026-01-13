`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2025 13:18:45
// Design Name: 
// Module Name: counter
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


module counter (
    input CLK,
    input RESET,
    output reg [3:0] COUNT
    );
    


always@ (posedge CLK or posedge RESET) begin
    if(RESET)
        COUNT= 0;
    else if(COUNT >= 15) 
        COUNT <= 0;
    else 
        COUNT <= COUNT + 1; 
end



endmodule
