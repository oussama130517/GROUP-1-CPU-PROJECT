
// ============================================================
//  CPU TOP - SINGLE-CYCLE 32-BIT RISC PROCESSOR
//  File    : cpu_top.v
//  Desc    : Complete processor core integrating:
//            - Program Counter (PC) + Incrementer
//            - Instruction Fetch & Decode
//            - Control Unit
//            - Register File
//            - ALU with Flags
//            - Memory interface
//            - All multiplexers for Harvard Architecture
// ============================================================

`timescale 1ns/1ps

module CPU_TOP (
    input  wire        clk,
    input  wire        rst,
    
    // Instruction Memory interface
    output wire [31:0] imem_addr,      // Address to IMEM
    input  wire [31:0] imem_data,      // Instruction from IMEM
    
    // Data Memory interface
    output wire [31:0] dmem_addr,      // Address to DMEM
    output wire [31:0] dmem_wdata,     // Write data to DMEM
    input  wire [31:0] dmem_rdata,     // Read data from DMEM
    output wire        dmem_rd,        // Read enable
    output wire        dmem_wr,        // Write enable
    
    // I/O interface
    input  wire [7:0]  io_addr,
    output wire [31:0] io_wdata,
    input  wire [31:0] io_rdata,
    output wire        io_rd,
    output wire        io_wr
);

    // ═════════════════════════════════════════════════════════════
    // INTERNAL WIRES AND SIGNALS
    // ═════════════════════════════════════════════════════════════

    // ── Program Counter and Incrementer ──────────────────────────
    wire [31:0] pc_current;
    wire [31:0] pc_next_seq    = pc_current + 32'h4;  // PC + 4
    wire [31:0] pc_branch;
    wire [31:0] pc_ret_addr;
    
    // ── Instruction fields (decoded from IMEM) ──────────────────
    wire [5:0]  opcode         = imem_data[31:26];
    wire [2:0]  rs1_addr       = imem_data[25:23];
    wire [2:0]  rs2_addr       = imem_data[22:20];
    wire [2:0]  rd_addr        = imem_data[19:17];
    wire [15:0] imm_16         = imem_data[15:0];
    wire [15:0] branch_offset  = imem_data[15:0];
    
    // ── Register File interface ──────────────────────────────────
    wire [31:0] rs1_data;      // Rs1 → ALU A input
    wire [31:0] rs2_data;      // Rs2 → ALU B / Memory
    wire [31:0] rd_write_data; // Write back data
    
    // ── Sign-extended immediate ──────────────────────────────────
    wire [31:0] imm_32;
    wire [30:0] imm_31;
    // ── Control Unit outputs ─────────────────────────────────────
    wire [3:0]  ALU_SEL;
    wire        IMM_SEL;
    wire        REG_WR;
    wire        MEM_RD;
    wire        MEM_WR;
    wire        MEM_SRC;
    wire        PUSH_EN;
    wire        POP_EN;
    wire        IO_RD_ctrl;
    wire        IO_WR_ctrl;
    wire [2:0]  PC_SEL;
    wire        BRANCH_EN;
    wire        SETC_EN;
    wire        CLRC_EN;
    
    // ── ALU interface ────────────────────────────────────────────
    wire [31:0] alu_a;         // ALU operand A
    wire [31:0] alu_b;         // ALU operand B
    wire [31:0] alu_result;
    wire        alu_c_out;
    wire        alu_z_flag;
    wire        alu_n_flag;
    wire        alu_v_flag;
    
    // ── Flags Register ───────────────────────────────────────────
    wire        n_flag, z_flag, c_flag, v_flag;
    wire        FLAGS_LD = REG_WR;  // Update flags when ALU writes
    
    // ── MUX: ALU B operand (Register or Immediate) ───────────────
    wire [31:0] alu_b_mux;
    
    // ── MUX: Write-back data source ──────────────────────────────
    // Sources: ALU result, Memory read, Immediate, I/O read
    wire [31:0] wb_alu;
    wire [31:0] wb_mem;
    wire [31:0] wb_imm;
    wire [31:0] wb_io;
    
    // ── MUX: Memory address source (Register or Immediate) ───────
    wire [31:0] mem_addr_mux;
    
    // ── Stack pointer (using R7 for stack) ───────────────────────
    wire [31:0] stack_ptr = rs2_data;  // Assume SP in R7
    wire [31:0] sp_pushed = stack_ptr - 32'h4;
    wire [31:0] sp_popped = stack_ptr + 32'h4;

    // ═════════════════════════════════════════════════════════════
    // MODULE INSTANTIATIONS
    // ═════════════════════════════════════════════════════════════

    // ── Program Counter Module ───────────────────────────────────
    PROGRAM_COUNTER u_pc (
        .clk          (clk),
        .rst          (rst),
        .pc_current   (pc_current),
        .pc_next_seq  (pc_next_seq),
        .pc_branch    (pc_branch),
        .pc_ret_addr  (pc_ret_addr),
        .PC_SEL       (PC_SEL),
        .BRANCH_EN    (BRANCH_EN)
    );

    // ── Branch Logic Module ──────────────────────────────────────
    BRANCH_LOGIC u_branch (
        .pc_current     (pc_current),
        .branch_offset  (branch_offset),
        .branch_target  (pc_branch)
    );

    // ── Control Unit Module ──────────────────────────────────────
    CONTROL_UNIT u_control (
        .opcode    (opcode),
        .N_flag    (n_flag),
        .Z_flag    (z_flag),
        .C_flag    (c_flag),
        .V_flag    (v_flag),
        .ALU_SEL   (ALU_SEL),
        .IMM_SEL   (IMM_SEL),
        .REG_WR    (REG_WR),
        .MEM_RD    (MEM_RD),
        .MEM_WR    (MEM_WR),
        .MEM_SRC   (MEM_SRC),
        .PUSH_EN   (PUSH_EN),
        .POP_EN    (POP_EN),
        .IO_RD     (IO_RD_ctrl),
        .IO_WR     (IO_WR_ctrl),
        .PC_SEL    (PC_SEL),
        .BRANCH_EN (BRANCH_EN),
        .SETC_EN   (SETC_EN),
        .CLRC_EN   (CLRC_EN)
    );

    // ── Register File Module ─────────────────────────────────────
    REG_FILE u_regfile (
        .clk        (clk),
        .rst        (rst),
        .rs1_addr   (rs1_addr),
        .rs1_data   (rs1_data),
        .rs2_addr   (rs2_addr),
        .rs2_data   (rs2_data),
        .rd_addr    (rd_addr),
        .rd_data    (rd_write_data),
        .wr_en      (REG_WR)
    );
  assign pc_ret_addr = pc_next_seq;
    // ── Sign Extend Module ───────────────────────────────────────
    SIGN_EXTEND u_sign_extend (
        .imm_31 (imm_31),
        .imm_32 (imm_32)
     );
  assign imm_31 = imem_data[30:0];
    // ── ALU Module ───────────────────────────────────────────────
    ALU_32 u_alu (
        .A        (alu_a),
        .B        (alu_b),
        .C_in     (c_flag),
        .ALU_SEL  (ALU_SEL),
        .Result   (alu_result),
        .C_out    (alu_c_out),
        .Z_flag   (alu_z_flag),
        .N_flag   (alu_n_flag),
        .V_flag   (alu_v_flag)
    );

    // ── Flags Register Module ────────────────────────────────────
    FLAGS_REGISTER u_flags (
        .clk      (clk),
        .rst      (rst),
        .N_in     (alu_n_flag),
        .Z_in     (alu_z_flag),
        .C_in     (alu_c_out),
        .V_in     (alu_v_flag),
        .SETC_EN  (SETC_EN),
        .CLRC_EN  (CLRC_EN),
        .FLAGS_LD (FLAGS_LD),
        .N_flag   (n_flag),
        .Z_flag   (z_flag),
        .C_flag   (c_flag),
        .V_flag   (v_flag)
    );

    // ═════════════════════════════════════════════════════════════
    // MULTIPLEXERS (MUX BLOCKS)
    // ═════════════════════════════════════════════════════════════

    // ── MUX1: ALU Operand B (Register vs Immediate) ──────────────
    // IMM_SEL=0: use Rs2 (register)
    // IMM_SEL=1: use sign-extended immediate
    assign alu_b = (IMM_SEL) ? imm_32 : rs2_data;

    // ── MUX2: ALU Operand A ─────────────────────────────────────
    // Always use Rs1
    assign alu_a = rs1_data;

    // ── MUX3: Memory Address Source (Register-indirect vs Immediate) ─
    // MEM_SRC=0: register-indirect (use Rs2)
    // MEM_SRC=1: immediate address
    assign mem_addr_mux = (MEM_SRC) ? imm_32 : rs2_data;

    // ── MUX4: Write-back Data Source ─────────────────────────────
    // Priority: Memory Read > ALU Result > Immediate > I/O Read
    assign wb_mem = dmem_rdata;
    assign wb_alu = alu_result;
    assign wb_imm = imm_32;
    assign wb_io  = io_rdata;
    
    // Write-back selector (based on instruction type)
    // This is simplified; a full implementation would have more states
    assign rd_write_data = (MEM_RD) ? wb_mem :
                          (IMM_SEL && ~MEM_RD && ~MEM_WR) ? wb_imm :
                          (IO_RD_ctrl) ? wb_io :
                          wb_alu;

    // ── Stack Push/Pop Address Calculation ───────────────────────
    assign dmem_addr = (PUSH_EN) ? sp_pushed :
                       (POP_EN)  ? stack_ptr :
                       mem_addr_mux;

    // ── Memory Write Data Source ────────────────────────────────
    // Can be from Rs2 (data to store) or ALU result
    assign dmem_wdata = rs2_data;  // Typically write data comes from Rs2

    // ═════════════════════════════════════════════════════════════
    // OUTPUT ASSIGNMENTS
    // ═════════════════════════════════════════════════════════════

    // Instruction Memory address (current PC)
    assign imem_addr = pc_current;

    // Data Memory outputs (already assigned above via MUX4)
    // dmem_addr, dmem_wdata assigned above
    
    // Data Memory control signals
    assign dmem_rd = MEM_RD;
    assign dmem_wr = MEM_WR;

    // I/O interface
    assign io_wdata = rs2_data;     // Write data from Rs2
    assign io_rd    = IO_RD_ctrl;
    assign io_wr    = IO_WR_ctrl;

endmodule

