`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 14:51:57
// Design Name: 
// Module Name: decoder_top_tb
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


module decoder_top_tb(

    );
    
reg [3:0] recieved_codeword;
reg CLK;
reg RESET;
wire [3:0] output_codeword;
    

decoder_top uut (
    .recieved_codeword(recieved_codeword),
    .CLK(CLK),
    .RESET(RESET),
    .output_codeword(output_codeword)
    );
    
initial begin
    CLK = 0;
    RESET = 1;
    #5;
    RESET = 0;
    #35;
    forever begin
        #5;
        CLK = ~CLK;
    end
end

initial begin
    #45;
    recieved_codeword = 1;
    #10;
    recieved_codeword = 2;
    #10;
    recieved_codeword = 3;
    #10;
    recieved_codeword = 4;
    #10;
    recieved_codeword = 5;
    #10;
    recieved_codeword = 11;
    #10;
    recieved_codeword = 7;
    #10;
    recieved_codeword = 8;
    #10;
    recieved_codeword = 9;
    #10;
    recieved_codeword = 10;
    #10;
    recieved_codeword = 11;
    #10;
    recieved_codeword = 3;
    #10;    
    recieved_codeword = 1;
    #10;
    recieved_codeword = 12;
    #10;
    recieved_codeword = 12;
    #10;
    recieved_codeword = 1;
    #10;
    recieved_codeword = 2;
    #10;
    recieved_codeword = 3;
    #10;
    recieved_codeword = 4;
    #10;
    recieved_codeword = 5;
    #10;
    recieved_codeword = 11;
    #10;
    recieved_codeword = 7;
    #10;
    recieved_codeword = 8;
    #10;
    recieved_codeword = 9;
    #10;
    recieved_codeword = 10;
    #10;
    recieved_codeword = 11;
    #10;
    recieved_codeword = 3;
    #10;    
    recieved_codeword = 1;
    #10;
    recieved_codeword = 12;
    #10;
    recieved_codeword = 12;
    #10;
end
    

    
endmodule
