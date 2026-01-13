`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2025 17:36:23
// Design Name: 
// Module Name: syndrome_top
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


module syndrome_top(
    input CLK,
    input RESET,
    input [3:0] IN_SERIAL,
    output [3:0] S_0,
    output [3:0] S_1,
    output [3:0] S_2,
    output [3:0] S_3,
    output [3:0] COUNT
    );
    
wire [3:0] CONTROL;
wire [3:0] flag;
reg RESET_ind;



always @(*) begin
    if (RESET || COUNT == 4'd15)
        RESET_ind <= 1'b1;
    else
        RESET_ind <= 1'b0;
end

syndrome_1 S1(
        .CLK(CLK),
        .RESET_GLOBAL(RESET_ind),
        .CONTROL(CONTROL),
        .IN_SERIAL(IN_SERIAL),
        .OUT_SERIAL(S_0)
        );
syndrome_2 S2(
        .CLK(CLK),
        .RESET_GLOBAL(RESET_ind),
        .CONTROL(CONTROL),
        .IN_SERIAL(IN_SERIAL),
        .OUT_SERIAL(S_1)
        );
syndrome_4 S3(
        .CLK(CLK),
        .RESET_GLOBAL(RESET_ind),
        .CONTROL(CONTROL),
        .IN_SERIAL(IN_SERIAL),
        .OUT_SERIAL(S_2)
        );
syndrome_8 S4(
        .CLK(CLK),
        .RESET_GLOBAL(RESET_ind),
        .CONTROL(CONTROL),
        .IN_SERIAL(IN_SERIAL),
        .OUT_SERIAL(S_3)
        );
control_machine CTRL(
                    .CLK(CLK),
                    .RESET(RESET),
                    .CONTROL(CONTROL),
                    .COUNT_out(flag)
                    );

assign COUNT = flag;


endmodule
