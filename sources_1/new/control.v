`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2025 20:45:03
// Design Name: 
// Module Name: control
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


module control(
    input [3:0] COUNT,
    input CLK,
    input RESET,
    output [3:0] CONTROL
    );
    
reg [3:0] Curr_state;
reg [3:0] Next_state;

parameter LOW = 4'b0000;
parameter HIGH = 4'b1111;
    
always@(posedge CLK or posedge RESET) begin
    if(RESET) begin 
    
        Curr_state <= HIGH;
    end
    else begin
        Curr_state <= Next_state;
    end
end


always@(COUNT) begin
    case(Curr_state)
        LOW: begin
        //at the start of one block open feedback loop
            if(COUNT == 15 ) begin
                
                Next_state = HIGH;
            end
            else begin
                
                Next_state = Curr_state;
            end 
        end
        HIGH: begin
            //after one block has passed, clear the register
            if(COUNT == 14) begin
                Next_state = LOW;
            end
            else begin
                Next_state = Curr_state;
            end
        end
        default:
            Next_state = HIGH;
   endcase 
end

assign CONTROL = Curr_state;
                
endmodule
