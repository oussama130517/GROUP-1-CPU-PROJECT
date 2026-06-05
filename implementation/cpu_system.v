// ============================================================
//  CPU SYSTEM WITH INTEGRATED MEMORIES
//  File    : cpu_system.v
//  Desc    : Top-level system integrating:
//            - CPU_TOP (processor core)
//            - INSTRUCTION_MEMORY (program code)
//            - DATA_MEMORY (stack + variables)
//            - I/O interface
// ============================================================

`timescale 1ns/1ps

module CPU_SYSTEM (
    input  wire        clk,
    input  wire        rst,
    
    // I/O ports (for external devices)
    input  wire [7:0]  io_addr,
    output wire [31:0] io_wdata,
    input  wire [31:0] io_rdata,
    output wire        io_rd,
    output wire        io_wr
);

    // ── Internal buses ───────────────────────────────────────────
    wire [31:0] imem_addr;
    wire [31:0] imem_data;
    
    wire [31:0] dmem_addr;
    wire [31:0] dmem_wdata;
    wire [31:0] dmem_rdata;
    wire        dmem_rd;
    wire        dmem_wr;

    // ── Instantiate CPU Core ─────────────────────────────────────
    CPU_TOP u_cpu (
        .clk         (clk),
        .rst         (rst),
        .imem_addr   (imem_addr),
        .imem_data   (imem_data),
        .dmem_addr   (dmem_addr),
        .dmem_wdata  (dmem_wdata),
        .dmem_rdata  (dmem_rdata),
        .dmem_rd     (dmem_rd),
        .dmem_wr     (dmem_wr),
        .io_addr     (io_addr),
        .io_wdata    (io_wdata),
        .io_rdata    (io_rdata),
        .io_rd       (io_rd),
        .io_wr       (io_wr)
    );

    // ── Instantiate Instruction Memory ──────────────────────────
    INSTRUCTION_MEMORY u_imem (
        .clk         (clk),
        .rst         (rst),
        .addr        (imem_addr),
        .instr_data  (imem_data)
    );

    // ── Instantiate Data Memory ────────────────────────────────
    DATA_MEMORY u_dmem (
        .clk         (clk),
        .rst         (rst),
        .rd_addr     (dmem_addr),
        .rd_data     (dmem_rdata),
        .rd_en       (dmem_rd),
        .wr_addr     (dmem_addr),
        .wr_data     (dmem_wdata),
        .wr_en       (dmem_wr)
    );

endmodule