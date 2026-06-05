// ============================================================
//  32-BIT RISC  –  CONTROL UNIT / INSTRUCTION DECODER
//  File    : control_unit.v
//  Desc    : Combinational decoder – generates all datapath
//            control signals from 6-bit opcode + flags
// ============================================================
 
module CONTROL_UNIT (
    input  wire [5:0] opcode,     // IR[31:26]
 
    // Flags feedback from Flags Register
    input  wire       N_flag,
    input  wire       Z_flag,
    input  wire       C_flag,
    input  wire       V_flag,
 
    // ── ALU control ──────────────────────────────────────────
    output reg  [3:0] ALU_SEL,
    output reg        IMM_SEL,    // 1 = use sign-extended imm as B
 
    // ── Register File ────────────────────────────────────────
    output reg        REG_WR,     // Rd write enable
 
    // ── Memory ───────────────────────────────────────────────
    output reg        MEM_RD,     // Data memory read
    output reg        MEM_WR,     // Data memory write
    output reg        MEM_SRC,    // 0=reg-indirect  1=imm address
 
    // ── Stack ────────────────────────────────────────────────
    output reg        PUSH_EN,
    output reg        POP_EN,
 
    // ── I/O ──────────────────────────────────────────────────
    output reg        IO_RD,
    output reg        IO_WR,
 
    // ── PC / Branch ──────────────────────────────────────────
    output reg  [2:0] PC_SEL,
    // 000=PC+1  001=branch  010=CALL  011=RET  100=RTI
    output reg        BRANCH_EN,  // branch condition satisfied
 
    // ── Special ──────────────────────────────────────────────
    output reg        SETC_EN,
    output reg        CLRC_EN
);
 
    // ── Opcode constants ──────────────────────────────────────
    // Logic / ALU
    localparam OPC_NOT  = 6'b000001;
    localparam OPC_AND  = 6'b000010;
    localparam OPC_OR   = 6'b000011;
    localparam OPC_XOR  = 6'b000100;
    localparam OPC_RLC  = 6'b000101;
    localparam OPC_RRC  = 6'b000110;
    localparam OPC_SETC = 6'b000111;
    localparam OPC_CLRC = 6'b001000;
    // Arithmetic
    localparam OPC_ADD  = 6'b001001;
    localparam OPC_SUB  = 6'b001010;
    localparam OPC_NEG  = 6'b001011;
    localparam OPC_INC  = 6'b001100;
    localparam OPC_DEC  = 6'b001101;
    // Jump / Flow
    localparam OPC_JMP  = 6'b010000;
    localparam OPC_JN   = 6'b010001;
    localparam OPC_JC   = 6'b010010;
    localparam OPC_JV   = 6'b010011;
    localparam OPC_JZ   = 6'b010100;
    localparam OPC_LOOP = 6'b010101;
    localparam OPC_CALL = 6'b010110;
    localparam OPC_RET  = 6'b010111;
    localparam OPC_RTI  = 6'b011000;
    // Memory
    localparam OPC_LDM  = 6'b011001;
    localparam OPC_LDD  = 6'b011010;
    localparam OPC_STD  = 6'b011011;
    localparam OPC_LDI  = 6'b011100;
    localparam OPC_STI  = 6'b011101;
    localparam OPC_PUSH = 6'b011110;
    localparam OPC_POP  = 6'b011111;
    localparam OPC_OUT  = 6'b100000;
    localparam OPC_IN   = 6'b100001;
 
    always @(*) begin
        // ── Default: all inactive ────────────────────────────
        ALU_SEL   = 4'b0000;
        IMM_SEL   = 1'b0;
        REG_WR    = 1'b0;
        MEM_RD    = 1'b0;
        MEM_WR    = 1'b0;
        MEM_SRC   = 1'b0;
        PUSH_EN   = 1'b0;
        POP_EN    = 1'b0;
        IO_RD     = 1'b0;
        IO_WR     = 1'b0;
        PC_SEL    = 3'b000;
        BRANCH_EN = 1'b0;
        SETC_EN   = 1'b0;
        CLRC_EN   = 1'b0;
 
        case (opcode)
 
            // ══ LOGIC / ALU ══════════════════════════════════
            OPC_NOT:  begin ALU_SEL = 4'b1000; REG_WR = 1'b1; end
            OPC_AND:  begin ALU_SEL = 4'b0101; REG_WR = 1'b1; end
            OPC_OR:   begin ALU_SEL = 4'b0110; REG_WR = 1'b1; end
            OPC_XOR:  begin ALU_SEL = 4'b0111; REG_WR = 1'b1; end
            OPC_RLC:  begin ALU_SEL = 4'b1001; REG_WR = 1'b1; end
            OPC_RRC:  begin ALU_SEL = 4'b1010; REG_WR = 1'b1; end
            OPC_SETC: begin ALU_SEL = 4'b1011; SETC_EN = 1'b1; end
            OPC_CLRC: begin ALU_SEL = 4'b1100; CLRC_EN = 1'b1; end
 
            // ══ ARITHMETIC ════════════════════════════════════
            OPC_ADD:  begin ALU_SEL = 4'b0000; REG_WR = 1'b1; end
            OPC_SUB:  begin ALU_SEL = 4'b0001; REG_WR = 1'b1; end
            OPC_NEG:  begin ALU_SEL = 4'b0010; REG_WR = 1'b1; end
            OPC_INC:  begin ALU_SEL = 4'b0011; REG_WR = 1'b1; end
            OPC_DEC:  begin ALU_SEL = 4'b0100; REG_WR = 1'b1; end
 
            // ══ JUMP / FLOW ═══════════════════════════════════
            OPC_JMP: begin
                PC_SEL = 3'b001; BRANCH_EN = 1'b1;
            end
            OPC_JN: begin
                PC_SEL = 3'b001; BRANCH_EN = N_flag;
            end
            OPC_JC: begin
                PC_SEL = 3'b001; BRANCH_EN = C_flag;
            end
            OPC_JV: begin
                PC_SEL = 3'b001; BRANCH_EN = V_flag;
            end
            OPC_JZ: begin
                PC_SEL = 3'b001; BRANCH_EN = Z_flag;
            end
            OPC_LOOP: begin
                // DEC Rs1 then branch if not zero
                ALU_SEL   = 4'b0100;
                REG_WR    = 1'b1;
                PC_SEL    = 3'b001;
                BRANCH_EN = ~Z_flag;
            end
            OPC_CALL: begin
                PC_SEL    = 3'b010;
                BRANCH_EN = 1'b1;
                PUSH_EN   = 1'b1;
                MEM_WR    = 1'b1;
            end
            OPC_RET: begin
                PC_SEL    = 3'b011;
                BRANCH_EN = 1'b1;
                POP_EN    = 1'b1;
                MEM_RD    = 1'b1;
            end
            OPC_RTI: begin
                PC_SEL    = 3'b100;
                BRANCH_EN = 1'b1;
                POP_EN    = 1'b1;
                MEM_RD    = 1'b1;
            end
 
            // ══ MEMORY ════════════════════════════════════════
            OPC_LDM: begin MEM_RD = 1'b1; MEM_SRC = 1'b1; REG_WR = 1'b1; end
            OPC_LDD: begin MEM_RD = 1'b1; MEM_SRC = 1'b0; REG_WR = 1'b1; end
            OPC_STD: begin MEM_WR = 1'b1; MEM_SRC = 1'b0; end
            OPC_LDI: begin IMM_SEL = 1'b1; REG_WR = 1'b1; end
            OPC_STI: begin MEM_WR = 1'b1; MEM_SRC = 1'b0; IMM_SEL = 1'b1; end
            OPC_PUSH: begin PUSH_EN = 1'b1; MEM_WR = 1'b1; end
            OPC_POP:  begin POP_EN  = 1'b1; MEM_RD = 1'b1; REG_WR = 1'b1; end
            OPC_OUT:  begin IO_WR = 1'b1; end
            OPC_IN:   begin IO_RD = 1'b1; REG_WR = 1'b1; end
 
            default: ; // NOP
        endcase
    end
 
endmodule