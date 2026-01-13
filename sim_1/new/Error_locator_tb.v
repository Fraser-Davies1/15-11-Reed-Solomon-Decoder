`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 13:00:37
// Design Name: 
// Module Name: Error_locator_tb
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


module Error_locator_tb(

    );
    
reg [3:0] Omega_0;
reg [3:0] Omega_1;
reg [3:0] Gamma_0;
reg [3:0] Gamma_1;
reg [3:0] Gamma_2;
wire [3:0] error_values;
reg CLK;
reg RESET;
reg CONTROL;
    
Error_Positioning uut (
        .Omega_0(Omega_0),
        .Omega_1(Omega_1),
        .Gamma_0(Gamma_0),
        .Gamma_1(Gamma_1),
        .Gamma_2(Gamma_2),
        .CLK(CLK),
        .CONTROL(CONTROL),
        .RESET(RESET),
        .error_values(error_values)
        );
    
initial begin
    CLK = 0;
    RESET = 1;
    #10;
    RESET = 0;
    #10;
    forever begin
        #10;
        CLK = ~CLK;
    end
end

initial begin
    Gamma_0 = 1;
    Gamma_1 = 14;
    Gamma_2 = 14;
    Omega_0 = 15;
    Omega_1 = 6;
    CONTROL = 0;
    #40;
    CONTROL = 1;
    #10;
    CONTROL = 0;
end

endmodule
