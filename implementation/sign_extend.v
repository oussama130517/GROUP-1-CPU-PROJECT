
// ============================================================
//  SIGN EXTEND MODULE
//  File    : sign_extend.v
//  Desc    : Extends "31-bit immediate values to 32-bit
//            with sign extension (for negative numbers)
// ============================================================

`timescale 1ns/1ps

module SIGN_EXTEND (
    input  wire [30:0] imm_31,     // 31-bit immediate from instruction
    output wire [31:0] imm_32  // 32-bit sign-extended immediate
);

    // Sign extend: if MSB=1, fill upper bits with 1s; if MSB=0, fill with 0s
    assign imm_32 = {imm_31[30], imm_31[30:0]};

endmodule
