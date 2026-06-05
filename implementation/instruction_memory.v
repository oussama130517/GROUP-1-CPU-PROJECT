// ============================================================
//  INSTRUCTION MEMORY (IMEM)
//  File    : instruction_memory.v
//  Desc    : Single-port ROM / RAM for storing instructions
//            32-bit words at 8-bit addressable locations
//            Supports up to 256 instructions (4 KB)
// ============================================================
 
`timescale 1ns/1ps
 
module INSTRUCTION_MEMORY (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] addr,      // Memory address (byte-addressed)
    output wire [31:0] instr_data // 32-bit instruction word
);
 
    // ── Memory array: 256 × 32-bit instructions ──────────────────
    // Supports addressable space: 0x00000000 to 0x000003FF (1024 bytes)
    // But for practical use: 256 instructions (addr[9:2] is used)
    reg [31:0] imem [0:255];
 
    // ── Asynchronous read ────────────────────────────────────────
    // Word-aligned access: ignore lower 2 bits of address
    assign instr_data = imem[addr[9:2]];
 
    // ── Optional: Synchronous reset initialization ───────────────
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Clear all instruction memory on reset
            for (i = 0; i < 256; i = i + 1)
                imem[i] <= 32'h0000_0000;
        end
    end
 
    // ── Optional: $readmemh support for loading hex files ────────
    // Uncomment to load instructions from a hex file at simulation start:
    // initial $readmemh("program.hex", imem);
 
endmodule