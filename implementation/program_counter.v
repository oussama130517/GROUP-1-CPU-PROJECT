
// ============================================================
//  PROGRAM COUNTER
//  File    : program_counter.v
//  Desc    : 32-bit Program Counter with incrementer (+4)
//            Selectable next PC source via PC_SEL:
//            000=PC+4  001=branch  010=CALL  011=RET  100=RTI
// ============================================================

`timescale 1ns/1ps

module PROGRAM_COUNTER (
    input  wire        clk,
    input  wire        rst,
    
    // Current PC output to instruction memory
    output reg  [31:0] pc_current,
    
    // Next PC sources
    input  wire [31:0] pc_next_seq,    // PC + 4 (sequential/default)
    input  wire [31:0] pc_branch,      // Branch target address
    input  wire [31:0] pc_ret_addr,    // Return address (from stack)
    
    // PC selection control
    input  wire [2:0]  PC_SEL,         // 000=PC+4  001=branch  010=CALL  011=RET  100=RTI
    input  wire        BRANCH_EN       // Enable branch/jump
);

    reg [31:0] pc_next;

    // ── PC multiplexer: select next PC source ────────────────────
    always @(*) begin
        case (PC_SEL)
            3'b000: pc_next = pc_next_seq;       // Default: PC+4 (sequential)
            3'b001: pc_next = (BRANCH_EN) ? pc_branch : pc_next_seq;  // Conditional branch
            3'b010: pc_next = (BRANCH_EN) ? pc_branch : pc_next_seq;  // CALL (always branch)
            3'b011: pc_next = pc_ret_addr;       // RET (return from subroutine)
            3'b100: pc_next = pc_ret_addr;       // RTI (return from interrupt)
            default: pc_next = pc_next_seq;      // Default fallback
        endcase
    end

    // ── Synchronous PC update ────────────────────────────────────
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_current <= 32'h0000_0000;  // Reset PC to start address
        end else begin
            pc_current <= pc_next;
        end
    end

endmodule

