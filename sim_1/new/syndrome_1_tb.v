`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2025 21:13:14
// Design Name: 
// Module Name: syndrome_1_tb
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


    
module syndrome_1_tb(
    
        );
        
    wire [3:0] out_serial;
    reg [3:0] in_serial;
    reg clk;
    reg reset;
    reg [3:0]control;
    
    syndrome_1 uut(
                    .CLK(clk),
                    .RESET(reset),
                    .IN_SERIAL(in_serial),
                    .CONTROL(control),
                    .OUT_SERIAL(out_serial)
                    );
                    
initial begin
    clk = 0;
    #5;
    forever begin
        #10;
        clk = ~clk;
    end
end

initial begin
    control = 0;
    #25;
    control = 15;
    #280;
    control = 0;
    #20;
    control = 15;
end

initial begin
    reset = 1;
    #2;
    reset = 0;
    #2;
    reset = 0;
    #301;
    reset = 1;
    #2;
    reset = 0;
end

initial begin
    in_serial = 1;
    #25;
    in_serial = 2;
    #20;
    in_serial = 3;
    #20;
    in_serial = 4;
    #20;
    in_serial = 5;
    #20;
    in_serial = 11;
    #20;
    in_serial = 7;
    #20;
    in_serial = 8;
    #20;
    in_serial = 9;
    #20;
    in_serial = 10;
    #20;
    in_serial = 11;
    #20;
    in_serial = 3;
    #20;
    in_serial = 1;
    #20;
    in_serial = 12;
    #20;
    in_serial = 12;
    #20;
end
endmodule
