`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2025 18:44:42
// Design Name: 
// Module Name: Euclid
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


module Euclid(
    input        CLK,
    input        RESET,
    input  [3:0] S_0,
    input  [3:0] S_1,
    input  [3:0] S_2,
    input  [3:0] S_3,
    input        START,
    output [3:0] LAMBDA_0,
    output [3:0] LAMBDA_1,
    output [3:0] LAMBDA_2,
    output [3:0] OMEGA_0,
    output [3:0] OMEGA_1,
    output finished
);

    wire [3:0] DIV_RES;
    wire [4:0] CONTROL;
    wire finished;  // This is a pulse from Euclid_div_sect

    wire [3:0] OMEGA_0I, OMEGA_1I;
    wire [3:0] LAMBDA_0I, LAMBDA_1I, LAMBDA_2I;

    wire [3:0] OMEGA_0F, OMEGA_1F;
    wire [3:0] LAMBDA_0F, LAMBDA_1F, LAMBDA_2F;

    // --------------------------------------------------
    // Controller
    // --------------------------------------------------
    Euclid_controller controller (
        .CLK    (CLK),
        .RESET  (RESET),
        .CONTROL(CONTROL),
        .START  (START)
    );

    // --------------------------------------------------
    // Euclid datapath
    // --------------------------------------------------
    Euclid_mult_sect half_1 (
        .div_res (DIV_RES),
        .CLK     (CLK),
        .RESET   (RESET),
        .shift   (finished),
        .CONTROL (CONTROL),
        .lambda0 (LAMBDA_0I),
        .lambda1 (LAMBDA_1I),
        .lambda2 (LAMBDA_2I)
    );

    Euclid_div_sect half_2 (
        .syndrome0 (S_0),
        .syndrome1 (S_1),
        .syndrome2 (S_2),
        .syndrome3 (S_3),
        .CLK       (CLK),
        .degree    (finished),
        .RESET     (RESET),
        .CONTROL   (CONTROL),
        .OUT       (DIV_RES),
        .omega1    (OMEGA_1I),
        .omega0    (OMEGA_0I)
    );

    // --------------------------------------------------
    // Final division
    // --------------------------------------------------
    lambda_divider final_divide (
        .Omega_0     (OMEGA_0I),
        .Omega_1     (OMEGA_1I),
        .Gamma_0     (LAMBDA_0I),
        .Gamma_1     (LAMBDA_1I),
        .Gamma_2     (LAMBDA_2I),
        .CLK         (CLK),
        .div_Omega_0 (OMEGA_0F),
        .div_Omega_1 (OMEGA_1F),
        .div_Gamma_0 (LAMBDA_0F),
        .div_Gamma_1 (LAMBDA_1F),
        .div_Gamma_2 (LAMBDA_2F)
    );

    // --------------------------------------------------
    // Holding registers (pipeline alignment)
    // --------------------------------------------------
    // Stage 1
    reg [3:0] omega0_d1, omega1_d1;
    reg [3:0] lambda0_d1, lambda1_d1, lambda2_d1;

    // Stage 2
    reg [3:0] omega0_d2, omega1_d2;
    reg [3:0] lambda0_d2, lambda1_d2, lambda2_d2;

    // Stage 3
    reg [3:0] omega0_d3, omega1_d3;
    reg [3:0] lambda0_d3, lambda1_d3, lambda2_d3;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            // stage 1
            omega0_d1  <= 4'd0;
            omega1_d1  <= 4'd0;
            lambda0_d1 <= 4'd0;
            lambda1_d1 <= 4'd0;
            lambda2_d1 <= 4'd0;

            // stage 2
            omega0_d2  <= 4'd0;
            omega1_d2  <= 4'd0;
            lambda0_d2 <= 4'd0;
            lambda1_d2 <= 4'd0;
            lambda2_d2 <= 4'd0;

            // stage 3
            omega0_d3  <= 4'd0;
            omega1_d3  <= 4'd0;
            lambda0_d3 <= 4'd0;
            lambda1_d3 <= 4'd0;
            lambda2_d3 <= 4'd0;
        end else begin
            // stage 1
            omega0_d1  <= OMEGA_0F;
            omega1_d1  <= OMEGA_1F;
            lambda0_d1 <= LAMBDA_0F;
            lambda1_d1 <= LAMBDA_1F;
            lambda2_d1 <= LAMBDA_2F;

            // stage 2
            omega0_d2  <= omega0_d1;
            omega1_d2  <= omega1_d1;
            lambda0_d2 <= lambda0_d1;
            lambda1_d2 <= lambda1_d1;
            lambda2_d2 <= lambda2_d1;

            // stage 3
            omega0_d3  <= omega0_d2;
            omega1_d3  <= omega1_d2;
            lambda0_d3 <= lambda0_d2;
            lambda1_d3 <= lambda1_d2;
            lambda2_d3 <= lambda2_d2;
        end
    end

    // --------------------------------------------------
    // Delay finished signal to align with pipeline
    // --------------------------------------------------
    reg finished_d1;  // 1 cycle delayed finished
    
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            finished_d1 <= 1'b0;
        end else begin
            finished_d1 <= finished;
        end
    end

    // --------------------------------------------------
    // Output holding registers
    // --------------------------------------------------
    reg [3:0] LAMBDA_0_reg, LAMBDA_1_reg, LAMBDA_2_reg;
    reg [3:0] OMEGA_0_reg, OMEGA_1_reg;
    reg output_hold_enable;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            LAMBDA_0_reg <= 4'd0;
            LAMBDA_1_reg <= 4'd0;
            LAMBDA_2_reg <= 4'd0;
            OMEGA_0_reg  <= 4'd0;
            OMEGA_1_reg  <= 4'd0;
            output_hold_enable <= 1'b0;
        end else begin
            // Use DELAYED finished signal to capture values at stage3
            // finished_d1 arrives 1 cycle after finished, when values are at stage3
            if (finished_d1) begin
                LAMBDA_0_reg <= lambda0_d3;
                LAMBDA_1_reg <= lambda1_d3;
                LAMBDA_2_reg <= lambda2_d3;
                OMEGA_0_reg  <= omega0_d3;
                OMEGA_1_reg  <= omega1_d3;
                output_hold_enable <= 1'b1;
            end
        end
    end

    // --------------------------------------------------
    // Output selection
    // --------------------------------------------------
    assign LAMBDA_0 = output_hold_enable ? LAMBDA_0_reg : 4'd0;
    assign LAMBDA_1 = output_hold_enable ? LAMBDA_1_reg : 4'd0;
    assign LAMBDA_2 = output_hold_enable ? LAMBDA_2_reg : 4'd0;
    assign OMEGA_0  = output_hold_enable ? OMEGA_0_reg  : 4'd0;
    assign OMEGA_1  = output_hold_enable ? OMEGA_1_reg  : 4'd0;

endmodule

