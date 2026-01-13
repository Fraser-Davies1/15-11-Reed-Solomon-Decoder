`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2025 21:14:36
// Design Name: 
// Module Name: Euclid_controller
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


module Euclid_controller (
    input        CLK,
    input        RESET,
    input        degree,
    input        START,
    output [4:0] CONTROL
);

    reg [4:0] Curr_state;
    reg [4:0] Next_state;
    reg [4:0] COUNT;
    reg start_detected;
    
    // 0th bit controls shift on/off
    // bits 1/2 control A and C registers
    // bits 3/4 control B and D registers
    // State encoding
    //                      SAABB
    //                      SCCDD
    parameter START_ST = 5'b00110;
    parameter STEP_ONE = 5'b01000;
    parameter STEP_TWO = 5'b10001;

    // Detect START pulse
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            start_detected <= 1'b0;
        end
        else if (START) begin
            start_detected <= 1'b1;
        end
        else if (Curr_state == START_ST) begin
            start_detected <= 1'b0;
        end
    end

    // counter
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            COUNT <= 5'd0;
        end
        else if (start_detected && Curr_state != START_ST) begin
            // Reset counter when start is detected but we haven't entered START_ST yet
            COUNT <= 5'd0;
        end
        else if (Curr_state == START_ST || Curr_state == STEP_ONE || Curr_state == STEP_TWO) begin
            if (COUNT >= 5'd6) begin
                COUNT <= 5'd0;
            end
            else begin
                COUNT <= COUNT + 5'd1;
            end
        end
        else begin
            COUNT <= 5'd0;
        end
    end

    // State register
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            Curr_state <= START_ST;
        end
        else begin
            Curr_state <= Next_state;
        end
    end

    // Next-state logic
    always @(*) begin
        Next_state = Curr_state;
        
        case (Curr_state)
            START_ST: begin
                if (COUNT == 5'd2) begin
                    Next_state = STEP_ONE;
                end
            end

            STEP_ONE: begin
                if (COUNT == 5'd3 || COUNT == 5'd5) begin
                    Next_state = STEP_TWO;
                end
            end

            STEP_TWO: begin
                if (COUNT == 5'd4) begin
                    Next_state = STEP_ONE;
                end
                else if (degree == 1'b1 || start_detected) begin
                    Next_state = START_ST;
                end
            end

            default: begin
                Next_state = START_ST;
            end
        endcase
    end

    assign CONTROL = Curr_state;

endmodule
