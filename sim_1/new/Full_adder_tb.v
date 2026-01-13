`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2025 15:37:26
// Design Name: 
// Module Name: Full_adder_tb
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


module Full_adder_tb(

    );
    
wire [3:0] out;
reg [3:0] in1;
reg [3:0] in2;

full_GF_mult uut (
                .A(in1),
                .B(in2),
                .out(out)
                );

integer i;
integer j;

initial begin
    
    
    for(i = 0; i < 16; i = i+1) begin
        for(j = 0; j < 16; j = j+1) begin
            #3;
            in1 = i;
            in2 = j;
        end
    end
end
endmodule
