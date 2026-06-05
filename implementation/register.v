// ============================================================
//  32-BIT RISC  –  REGISTER FILE
//  File    : reg_file.v
//  Desc    : 8 × 32-bit registers (R0–R7)
//            Dual async read ports, single sync write port
//            R0 hard-wired to 0x00000000 (writes ignored)
// ============================================================
 
module REG_FILE (
    input  wire        clk,
    input  wire        rst,
 
    // Read port 1 (Rs1 → ALU A)
    input  wire [2:0]  rs1_addr,
    output wire [31:0] rs1_data,
 
    // Read port 2 (Rs2 → ALU B / MEM)
    input  wire [2:0]  rs2_addr,
    output wire [31:0] rs2_data,
 
    // Write port (Rd ← WB result)
    input  wire [2:0]  rd_addr,
    input  wire [31:0] rd_data,
    input  wire        wr_en
);
 
    reg [31:0] regs [0:7];
    integer i;
 
    // ── Synchronous write (R0 protected) ─────────────────────
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1)
                regs[i] <= 32'h0;
        end else if (wr_en && (rd_addr != 3'b000)) begin
            regs[rd_addr] <= rd_data;
        end
    end
 
    // ── Asynchronous read (R0 always returns 0) ───────────────
    assign rs1_data = (rs1_addr == 3'b000) ? 32'h0 : regs[rs1_addr];
    assign rs2_data = (rs2_addr == 3'b000) ? 32'h0 : regs[rs2_addr];
 
endmodule