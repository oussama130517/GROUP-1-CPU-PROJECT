
// ============================================================
//  BRANCH LOGIC
//  File    : branch_logic.v
//  Desc    : Calculates branch target address
//            Target = PC + 4 + (sign-extended offset)
// ============================================================

`timescale 1ns/1ps

module BRANCH_LOGIC (
    input  wire [31:0] pc_current,     // Current program counter
    input  wire [15:0] branch_offset,  // 16-bit branch offset from instruction
    output wire [31:0] branch_target   // Calculated target address
);

    // Sign-extend the offset and add to PC+4
    // branch_target = PC + 4 + offset
    wire [31:0] offset_extended = {{16{branch_offset[15]}}, branch_offset};
    
    assign branch_target = pc_current + 32'h4 + offset_extended;

endmodule

