`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 16:26:07
// Design Name: 
// Module Name: controller_tb
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


module controller_tb(

    );
    
reg clk;
reg reset;
wire [4:0] control;
   
Euclid_controller uut(
        .CLK(clk),
        .RESET(reset),
        .CONTROL(control)
        ); 

initial begin
    reset = 1;
    clk = 0;
    #5;
    reset = 0;
    #5;
    forever begin
        clk = ~clk;
        #10;
    end
end
    
endmodule
