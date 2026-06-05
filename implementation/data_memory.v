// ============================================================
//  DATA MEMORY (DMEM)
//  File    : data_memory.v
//  Desc    : Dual-port synchronous RAM for data storage
//            32-bit words at 8-bit addressable locations
//            Supports up to 256 data words (4 KB)
//            Used for stack, variables, arrays
// ============================================================

`timescale 1ns/1ps

module DATA_MEMORY (
    input  wire        clk,
    input  wire        rst,
    
    // Read port
    input  wire [31:0] rd_addr,    // Read address
    output wire [31:0] rd_data,    // Data read output
    input  wire        rd_en,      // Read enable
    
    // Write port
    input  wire [31:0] wr_addr,    // Write address
    input  wire [31:0] wr_data,    // Data to write
    input  wire        wr_en       // Write enable
);

    // ── Memory array: 256 × 32-bit data ──────────────────────────
    // Address space: 0x00000000 to 0x000003FF (1024 bytes)
    // Practical use: 256 words (addr[9:2] is used)
    reg [31:0] dmem [0:255];

    // ── Asynchronous read (combinational) ────────────────────────
    assign rd_data = (rd_en) ? dmem[rd_addr[9:2]] : 32'hxxxx_xxxx;

    // ── Synchronous write ────────────────────────────────────────
    // Word-aligned access: ignore lower 2 bits of address
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Clear all data memory on reset
            for (int i = 0; i < 256; i = i + 1)
                dmem[i] <= 32'h0000_0000;
        end else if (wr_en) begin
            // Write on clock edge if write enabled
            dmem[wr_addr[9:2]] <= wr_data;
        end
    end

endmodule