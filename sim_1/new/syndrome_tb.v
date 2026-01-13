`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2025 13:27:23
// Design Name: 
// Module Name: syndrome_tb
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


module syndrome_tb(

    );
    
wire [3:0] s_0;
wire [3:0] s_1;
wire [3:0] s_2;
wire [3:0] s_3;
reg [3:0] in_serial;
reg clk;
reg reset;
syndrome_top uut(
                .CLK(clk),
                .RESET(reset),
                .IN_SERIAL(in_serial),
                .S_0(s_0),
                .S_1(s_1),
                .S_2(s_2),
                .S_3(s_3)
                );
                
initial begin
    
    clk = 0;
    forever begin
        #5;
        clk = ~clk;
    end
end

initial begin
    reset = 1;
    #2;
    reset = 0;
    #2;
end

initial begin
    #155;
    in_serial = 1;
    #10;
    in_serial = 2;
    #10;
    in_serial = 3;
    #10;
    in_serial = 4;
    #10;
    in_serial = 5;
    #10;
    in_serial = 11;
    #10;
    in_serial = 7;
    #10;
    in_serial = 8;
    #10;
    in_serial = 9;
    #10;
    in_serial = 10;
    #10;
    in_serial = 11;
    #10;
    in_serial = 3;
    #10;
    in_serial = 1;
    #10;
    in_serial = 12;
    #10;
    in_serial = 12;
    #10;
    in_serial = 1;
        #10;
        in_serial = 2;
        #10;
        in_serial = 3;
        #10;
        in_serial = 4;
        #10;
        in_serial = 5;
        #10;
        in_serial = 11;
        #10;
        in_serial = 7;
        #10;
        in_serial = 8;
        #10;
        in_serial = 9;
        #10;
        in_serial = 10;
        #10;
        in_serial = 11;
        #10;
        in_serial = 3;
        #10;
        in_serial = 1;
        #10;
        in_serial = 12;
        #10;
        in_serial = 12;
        #10;
end
endmodule
