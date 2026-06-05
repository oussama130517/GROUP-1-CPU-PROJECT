// ============================================================
//  32-BIT RISC ALU  –  IEEE 754 Single-Precision Compliant
//  File    : alu_32.v
//  Desc    : Full ALU – ADD SUB NEG INC DEC
//                       AND OR  XOR NOT
//                       RLC RRC SETC CLRC
// ============================================================
 
module ALU_32 (
    input  wire [31:0] A,        // Operand A (Rs1)
    input  wire [31:0] B,        // Operand B (Rs2 or Imm)
    input  wire        C_in,     // Carry in (from Flags register)
    input  wire [3:0]  ALU_SEL,  // Operation select
 
    output reg  [31:0] Result,   // 32-bit result → Rd
    output reg         C_out,    // Carry out
    output wire        Z_flag,   // Zero   flag
    output wire        N_flag,   // Negative flag
    output reg         V_flag    // Overflow flag
);
 
    // ── ALU_SEL encoding ──────────────────────────────────────
    localparam OP_ADD  = 4'b0000;
    localparam OP_SUB  = 4'b0001;
    localparam OP_NEG  = 4'b0010;
    localparam OP_INC  = 4'b0011;
    localparam OP_DEC  = 4'b0100;
    localparam OP_AND  = 4'b0101;
    localparam OP_OR   = 4'b0110;
    localparam OP_XOR  = 4'b0111;
    localparam OP_NOT  = 4'b1000;
    localparam OP_RLC  = 4'b1001;
    localparam OP_RRC  = 4'b1010;
    localparam OP_SETC = 4'b1011;
    localparam OP_CLRC = 4'b1100;
 
    // 33-bit wires for carry detection
    wire [32:0] A_ext = {1'b0, A};
    wire [32:0] B_ext = {1'b0, B};
    reg  [32:0] Res33;
 
    // ── Continuous flag assignments ───────────────────────────
    assign Z_flag = (Result == 32'h0000_0000);
    assign N_flag = Result[31];  // MSB = sign (IEEE 754 / 2's complement)
 
    // ── Main ALU combinational block ──────────────────────────
    always @(*) begin
        Res33  = 33'b0;
        Result = 32'b0;
        C_out  = 1'b0;
        V_flag = 1'b0;
 
        case (ALU_SEL)
 
            // ── Arithmetic ──────────────────────────────────
            OP_ADD: begin
                Res33  = A_ext + B_ext;
                Result = Res33[31:0];
                C_out  = Res33[32];
                V_flag = (~A[31] & ~B[31] & Result[31]) |
                         ( A[31] &  B[31] & ~Result[31]);
            end
 
            OP_SUB: begin
                Res33  = A_ext - B_ext;
                Result = Res33[31:0];
                C_out  = ~Res33[32];   // C=1 → no borrow (A >= B)
                V_flag = (~A[31] &  B[31] & Result[31]) |
                         ( A[31] & ~B[31] & ~Result[31]);
            end
 
            OP_NEG: begin
                Res33  = {1'b0, ~A} + 33'd1;
                Result = Res33[31:0];
                C_out  = Res33[32];
                V_flag = (A == 32'h8000_0000) ? 1'b1 : 1'b0;
            end
 
            OP_INC: begin
                Res33  = A_ext + 33'd1;
                Result = Res33[31:0];
                C_out  = Res33[32];
                V_flag = (A == 32'h7FFF_FFFF) ? 1'b1 : 1'b0;
            end
 
            OP_DEC: begin
                Res33  = A_ext - 33'd1;
                Result = Res33[31:0];
                C_out  = ~Res33[32];
                V_flag = (A == 32'h8000_0000) ? 1'b1 : 1'b0;
            end
 
            // ── Bitwise Logic ────────────────────────────────
            OP_AND: begin Result = A & B;  C_out = 1'b0; end
            OP_OR:  begin Result = A | B;  C_out = 1'b0; end
            OP_XOR: begin Result = A ^ B;  C_out = 1'b0; end
            OP_NOT: begin Result = ~A;     C_out = 1'b0; end
 
            // ── Rotate through Carry ─────────────────────────
            OP_RLC: begin
                // new[0] = C_in,  new_C = A[31]
                Result = {A[30:0], C_in};
                C_out  = A[31];
            end
 
            OP_RRC: begin
                // new[31] = C_in, new_C = A[0]
                Result = {C_in, A[31:1]};
                C_out  = A[0];
            end
 
            // ── Carry Control ────────────────────────────────
            OP_SETC: begin Result = A; C_out = 1'b1; end
            OP_CLRC: begin Result = A; C_out = 1'b0; end
 
            default: begin Result = 32'b0; C_out = 1'b0; end
        endcase
    end
 
endmodule
 
 

