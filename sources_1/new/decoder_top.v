`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 14:09:20
// Design Name: 
// Module Name: decoder_top
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


module decoder_top(
    input [3:0] recieved_codeword,
    input CLK,
    input RESET,
    output [3:0] output_codeword
    );
    
wire [3:0] flag;

reg START;


//registers and logic to capture the syndrome values once complete (15 CLK cycles)
reg [3:0] syndrome_0;
reg [3:0] syndrome_1;
reg [3:0] syndrome_2;
reg [3:0] syndrome_3;

wire [3:0] syndrome_0_in;
wire [3:0] syndrome_1_in;
wire [3:0] syndrome_2_in;
wire [3:0] syndrome_3_in;
    

always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        syndrome_0 <= 4'd0;
        syndrome_1 <= 4'd0;
        syndrome_2 <= 4'd0;
        syndrome_3 <= 4'd0;
        START      <= 1'b0;
// when COUNT = 14 the computation is complete. 
// capture the values
    end else if (flag == 4'd14) begin
        syndrome_0 <= syndrome_0_in;
        syndrome_1 <= syndrome_1_in;
        syndrome_2 <= syndrome_2_in;
        syndrome_3 <= syndrome_3_in;
        START      <= 1'b1;   // one-cycle pulse

    end else begin
        START <= 1'b0;        // default
    end
end




// calculate syndromes from input codeword
syndrome_top block_syndrome (
        .CLK(CLK),
        .RESET(RESET),
        .IN_SERIAL(recieved_codeword),
        .S_0(syndrome_0_in),
        .S_1(syndrome_1_in),
        .S_2(syndrome_2_in),
        .S_3(syndrome_3_in),
        .COUNT(flag)
        );
        
wire [3:0] L_0;
wire [3:0] L_1;
wire [3:0] L_2;
wire [3:0] Om_0;
wire [3:0] Om_1;

wire euclid_finished;
        
// Using syndromes, calculate error locator polynomial using euclidian algorithm
// for polynomial division
Euclid block_euclidian(
            .CLK(CLK),
            .RESET(RESET),
            .S_0(syndrome_0),
            .S_1(syndrome_1),
            .S_2(syndrome_2),
            .S_3(syndrome_3),
            .START(START),
            .LAMBDA_0(L_0),
            .LAMBDA_1(L_1),
            .LAMBDA_2(L_2),
            .OMEGA_0(Om_0),
            .OMEGA_1(Om_1),
            .finished(euclid_finished)
            );
            
wire [3:0] error_vector;
            
// use error locator polynomial to produce an error vector
Error_Positioning block_error_finding (
                .Omega_0(Om_0),
                .Omega_1(Om_1),
                .Gamma_0(L_0),
                .Gamma_1(L_1),
                .Gamma_2(L_2),
                .CLK(CLK),
                .CONTROL(euclid_finished),
                .RESET(RESET),
                .error_values(error_vector)
                );
                
wire [3:0] recieved_codeword_d;
             
// delay the input codeword by 560ns to align with error vector   
delay_finished_signal data_delay(
                .CLK(CLK),
                .RESET(RESET),
                .finished_in(recieved_codeword),
                .finished_out(recieved_codeword_d)
                );

// add the error vector to the delayed codeword to correct errors
GF_ADDER final_add(
    .IN1(recieved_codeword_d),
    .IN2(error_vector),
    .OUT(output_codeword)
    );


endmodule
