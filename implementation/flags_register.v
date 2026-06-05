
// ============================================================
//  FLAGS REGISTER
//  File    : flags_register.v
//  Desc    : Stores status flags: N (negative), Z (zero), 
//            C (carry), V (overflow)
// ============================================================

`timescale 1ns/1ps

module FLAGS_REGISTER (
    input  wire        clk,
    input  wire        rst,
    
    // Flag inputs from ALU
    input  wire        N_in,      // Negative flag
    input  wire        Z_in,      // Zero flag
    input  wire        C_in,      // Carry flag
    input  wire        V_in,      // Overflow flag
    
    // Flag update control signals
    input  wire        SETC_EN,   // Set carry flag
    input  wire        CLRC_EN,   // Clear carry flag
    input  wire        FLAGS_LD,  // Load/update all flags from ALU
    
    // Flag outputs to Control Unit
    output reg         N_flag,
    output reg         Z_flag,
    output reg         C_flag,
    output reg         V_flag
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            N_flag <= 1'b0;
            Z_flag <= 1'b0;
            C_flag <= 1'b0;
            V_flag <= 1'b0;
        end else begin
            if (SETC_EN) begin
                C_flag <= 1'b1;
            end else if (CLRC_EN) begin
                C_flag <= 1'b0;
            end else if (FLAGS_LD) begin
                N_flag <= N_in;
                Z_flag <= Z_in;
                C_flag <= C_in;
                V_flag <= V_in;
            end
        end
    end

endmodule
