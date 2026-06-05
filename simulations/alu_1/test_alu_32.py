"""
============================================================
  32-BIT RISC ALU – cocotb Testbench
  File    : test_alu_32.py
  Desc    : Comprehensive tests for all 13 ALU operations
            covering results, carry, overflow, zero & sign flags.
============================================================
"""

import cocotb
from cocotb.triggers import Timer


# ── ALU_SEL encodings ─────────────────────────────────────────────────────────
OP_ADD  = 0b0000
OP_SUB  = 0b0001
OP_NEG  = 0b0010
OP_INC  = 0b0011
OP_DEC  = 0b0100
OP_AND  = 0b0101
OP_OR   = 0b0110
OP_XOR  = 0b0111
OP_NOT  = 0b1000
OP_RLC  = 0b1001
OP_RRC  = 0b1010
OP_SETC = 0b1011
OP_CLRC = 0b1100


# ── Helpers ───────────────────────────────────────────────────────────────────

async def apply(dut, sel, A=0, B=0, C_in=0, settle_ns=2):
    dut.ALU_SEL.value = sel
    dut.A.value       = A & 0xFFFF_FFFF
    dut.B.value       = B & 0xFFFF_FFFF
    dut.C_in.value    = C_in
    await Timer(settle_ns, units="ns")


def u32(x):
    """Mask to 32-bit unsigned."""
    return x & 0xFFFF_FFFF


def check(dut, result=None, C_out=None, Z_flag=None, N_flag=None, V_flag=None):
    label = f"[SEL={int(dut.ALU_SEL.value):04b} A={int(dut.A.value):08X} B={int(dut.B.value):08X}]"
    if result is not None:
        got = int(dut.Result.value)
        assert got == u32(result), f"{label} Result: expected {u32(result):08X}, got {got:08X}"
    if C_out is not None:
        got = int(dut.C_out.value)
        assert got == C_out, f"{label} C_out: expected {C_out}, got {got}"
    if Z_flag is not None:
        got = int(dut.Z_flag.value)
        assert got == Z_flag, f"{label} Z_flag: expected {Z_flag}, got {got}"
    if N_flag is not None:
        got = int(dut.N_flag.value)
        assert got == N_flag, f"{label} N_flag: expected {N_flag}, got {got}"
    if V_flag is not None:
        got = int(dut.V_flag.value)
        assert got == V_flag, f"{label} V_flag: expected {V_flag}, got {got}"


# ── ADD ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_add_basic(dut):
    """5 + 3 = 8, no carry, no overflow."""
    await apply(dut, OP_ADD, A=8, B=3)
    check(dut, result=11, C_out=0, Z_flag=0, N_flag=0, V_flag=0)

@cocotb.test()
async def test_add_carry(dut):
    """0xFFFFFFFF + 1 → 0, carry=1."""
    await apply(dut, OP_ADD, A=0xFFFF_FFFF, B=1)
    check(dut, result=0, C_out=1, Z_flag=1, N_flag=0)

@cocotb.test()
async def test_add_overflow_positive(dut):
    """MAX_POS + 1 → overflow (positive + positive = negative)."""
    await apply(dut, OP_ADD, A=0x7FFF_FFFF, B=1)
    check(dut, result=0x8000_0000, C_out=0, V_flag=1, N_flag=1)

@cocotb.test()
async def test_add_overflow_negative(dut):
    """MIN_NEG + MIN_NEG → overflow (negative + negative = positive)."""
    await apply(dut, OP_ADD, A=0x8000_0000, B=0xFFFF_FFFF)
    check(dut, C_out=1, V_flag=1, Z_flag=0)

@cocotb.test()
async def test_add_zero_result(dut):
    """0 + 0 = 0, Z_flag=1."""
    await apply(dut, OP_ADD, A=0, B=0)
    check(dut, result=0, C_out=0, Z_flag=1, N_flag=0, V_flag=0)


# ── SUB ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_sub_basic(dut):
    """10 - 4 = 6, no borrow → C=1."""
    await apply(dut, OP_SUB, A=10, B=4)
    check(dut, result=6, C_out=1, Z_flag=0, N_flag=0, V_flag=0)

@cocotb.test()
async def test_sub_borrow(dut):
    """3 - 5 → borrow → C=0, result negative."""
    await apply(dut, OP_SUB, A=3, B=5)
    check(dut, result=u32(-2), C_out=0, N_flag=1)

@cocotb.test()
async def test_sub_zero(dut):
    """A - A = 0, Z=1, C=1 (no borrow)."""
    await apply(dut, OP_SUB, A=0xABCD_1234, B=0xABCD_1234)
    check(dut, result=0, C_out=1, Z_flag=1, V_flag=0)

@cocotb.test()
async def test_sub_overflow(dut):
    """MIN_NEG - 1 → overflow (most negative minus positive)."""
    await apply(dut, OP_SUB, A=0x8000_0000, B=1)
    check(dut, result=0x7FFF_FFFF, V_flag=1, N_flag=0)

@cocotb.test()
async def test_sub_pos_minus_neg_overflow(dut):
    """MAX_POS - (-1) → overflow."""
    await apply(dut, OP_SUB, A=0x7FFF_FFFF, B=0xFFFF_FFFF)
    check(dut, result=0x8000_0000, V_flag=1, N_flag=1)


# ── NEG ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_neg_basic(dut):
    """-5 = 0xFFFFFFFB, carry out = 1."""
    await apply(dut, OP_NEG, A=5)
    check(dut, result=u32(-5), C_out=0, N_flag=1, Z_flag=0, V_flag=0)

@cocotb.test()
async def test_neg_zero(dut):
    """NEG(0) = 0, Z=1, C=0."""
    await apply(dut, OP_NEG, A=0)
    check(dut, result=0, C_out=1, Z_flag=1, V_flag=0)

@cocotb.test()
async def test_neg_min(dut):
    """NEG(0x80000000) = 0x80000000, overflow."""
    await apply(dut, OP_NEG, A=0x8000_0000)
    check(dut, result=0x8000_0000, V_flag=1)


# ── INC ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_inc_basic(dut):
    """7 + 1 = 8."""
    await apply(dut, OP_INC, A=7)
    check(dut, result=8, C_out=0, V_flag=0, Z_flag=0)

@cocotb.test()
async def test_inc_carry(dut):
    """0xFFFFFFFF + 1 → 0, carry."""
    await apply(dut, OP_INC, A=0xFFFF_FFFF)
    check(dut, result=0, C_out=1, Z_flag=1)

@cocotb.test()
async def test_inc_overflow(dut):
    """MAX_POS + 1 → overflow."""
    await apply(dut, OP_INC, A=0x7FFF_FFFF)
    check(dut, result=0x8000_0000, V_flag=1, N_flag=1)


# ── DEC ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_dec_basic(dut):
    """8 - 1 = 7, C=1 (no borrow)."""
    await apply(dut, OP_DEC, A=8)
    check(dut, result=7, C_out=1, V_flag=0, Z_flag=0)

@cocotb.test()
async def test_dec_borrow(dut):
    """0 - 1 → borrow, C=0."""
    await apply(dut, OP_DEC, A=0)
    check(dut, result=0xFFFF_FFFF, C_out=0, N_flag=1)

@cocotb.test()
async def test_dec_overflow(dut):
    """MIN_NEG - 1 → overflow."""
    await apply(dut, OP_DEC, A=0x8000_0000)
    check(dut, result=0x7FFF_FFFF, V_flag=1, N_flag=0)

@cocotb.test()
async def test_dec_to_zero(dut):
    """1 - 1 = 0, Z=1."""
    await apply(dut, OP_DEC, A=1)
    check(dut, result=0, C_out=1, Z_flag=1)


# ── AND ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_and_basic(dut):
    await apply(dut, OP_AND, A=0xFF00FF00, B=0x0F0F0F0F)
    check(dut, result=0x0F000F00, C_out=0)

@cocotb.test()
async def test_and_zero(dut):
    """A & ~A = 0, Z=1."""
    await apply(dut, OP_AND, A=0xAAAA_AAAA, B=0x5555_5555)
    check(dut, result=0, Z_flag=1, C_out=0)

@cocotb.test()
async def test_and_all_ones(dut):
    """A & 0xFFFFFFFF = A."""
    await apply(dut, OP_AND, A=0xDEAD_BEEF, B=0xFFFF_FFFF)
    check(dut, result=0xDEAD_BEEF, C_out=0)


# ── OR ────────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_or_basic(dut):
    await apply(dut, OP_OR, A=0xFF00FF00, B=0x0F0F0F0F)
    check(dut, result=0xFF0FFF0F, C_out=0)

@cocotb.test()
async def test_or_with_zero(dut):
    """A | 0 = A."""
    await apply(dut, OP_OR, A=0xCAFE_BABE, B=0)
    check(dut, result=0xCAFE_BABE, C_out=0)


# ── XOR ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_xor_same(dut):
    """A ^ A = 0, Z=1."""
    await apply(dut, OP_XOR, A=0xFFFF_FFFF, B=0xFFFF_FFFF)
    check(dut, result=0, Z_flag=1, C_out=0)

@cocotb.test()
async def test_xor_basic(dut):
    await apply(dut, OP_XOR, A=0xAAAA_AAAA, B=0x5555_5555)
    check(dut, result=0xFFFF_FFFF, C_out=0, N_flag=1)

@cocotb.test()
async def test_xor_with_zero(dut):
    """A ^ 0 = A."""
    await apply(dut, OP_XOR, A=0x1234_5678, B=0)
    check(dut, result=0x1234_5678, C_out=0)


# ── NOT ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_not_zero(dut):
    """~0 = 0xFFFFFFFF."""
    await apply(dut, OP_NOT, A=0)
    check(dut, result=0xFFFF_FFFF, C_out=0, N_flag=1, Z_flag=0)

@cocotb.test()
async def test_not_all_ones(dut):
    """~0xFFFFFFFF = 0, Z=1."""
    await apply(dut, OP_NOT, A=0xFFFF_FFFF)
    check(dut, result=0, C_out=0, Z_flag=1)

@cocotb.test()
async def test_not_pattern(dut):
    await apply(dut, OP_NOT, A=0xAAAA_AAAA)
    check(dut, result=0x5555_5555, C_out=0)


# ── RLC ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_rlc_cin0(dut):
    """RLC: MSB→C_out, C_in→LSB. C_in=0."""
    await apply(dut, OP_RLC, A=0x8000_0001, C_in=0)
    # {A[30:0], C_in} = {0x0000001, 0} = 0x00000002, C_out=A[31]=1
    check(dut, result=0x0000_0002, C_out=1)

@cocotb.test()
async def test_rlc_cin1(dut):
    """RLC with C_in=1 shifts into bit 0."""
    await apply(dut, OP_RLC, A=0x4000_0000, C_in=1)
    # {A[30:0], 1} = 0x80000001, C_out=A[31]=0
    check(dut, result=0x8000_0001, C_out=0, N_flag=1)

@cocotb.test()
async def test_rlc_zero_in_zero_out(dut):
    """All-zero data, C_in=0 → all zero, C_out=0."""
    await apply(dut, OP_RLC, A=0, C_in=0)
    check(dut, result=0, C_out=0, Z_flag=1)


# ── RRC ───────────────────────────────────────────────────────────────────────

@cocotb.test()
async def test_rrc_cin1(dut):
    """RRC: LSB→C_out, C_in→MSB. C_in=1."""
    await apply(dut, OP_RRC, A=0x0000_0001, C_in=1)
    # {C_in, A[31:1]} = {1, 0x0000000} = 0x80000000, C_out=A[0]=1
    check(dut, result=0x8000_0000, C_out=1, N_flag=1)

@cocotb.test()
async def test_rrc_cin0(dut):
    """RRC with C_in=0."""
    await apply(dut, OP_RRC, A=0x8000_0000, C_in=0)
    # {0, A[31:1]} = 0x40000000, C_out=A[0]=0
    check(dut, result=0x4000_0000, C_out=0)

@cocotb.test()
async def test_rrc_lsb_to_carry(dut):
    """LSB propagates to C_out."""
    await apply(dut, OP_RRC, A=0x0000_0003, C_in=0)
    # {0, 0x0000001} = 0x00000001, C_out=1
    check(dut, result=0x0000_0001, C_out=1)


# ── SETC / CLRC ───────────────────────────────────────────────────────────────

@cocotb.test()
async def test_setc(dut):
    """SETC: pass A through, force C_out=1."""
    await apply(dut, OP_SETC, A=0x1234_5678)
    check(dut, result=0x1234_5678, C_out=1)

@cocotb.test()
async def test_clrc(dut):
    """CLRC: pass A through, force C_out=0."""
    await apply(dut, OP_CLRC, A=0x1234_5678)
    check(dut, result=0x1234_5678, C_out=0)

@cocotb.test()
async def test_setc_zero_input(dut):
    """SETC with A=0: Z_flag=1, C_out=1."""
    await apply(dut, OP_SETC, A=0)
    check(dut, result=0, C_out=1, Z_flag=1)


# ── Default / unknown sel ─────────────────────────────────────────────────────

@cocotb.test()
async def test_default_sel(dut):
    """Undefined ALU_SEL (0b1101–0b1111) → Result=0, C_out=0."""
    for sel in [0b1101, 0b1110, 0b1111]:
        await apply(dut, sel, A=0xDEAD_BEEF, B=0xCAFE_BABE)
        check(dut, result=0, C_out=0, Z_flag=1)


# ── Z / N flag edge cases ─────────────────────────────────────────────────────

@cocotb.test()
async def test_n_flag_set(dut):
    """N_flag=1 whenever MSB of Result is 1."""
    await apply(dut, OP_ADD, A=0x8000_0000, B=0)
    check(dut, result=0x8000_0000, N_flag=1, Z_flag=0)

@cocotb.test()
async def test_z_and_n_mutually_exclusive(dut):
    """Non-zero negative result: Z=0, N=1."""
    await apply(dut, OP_NOT, A=0x7FFF_FFFF)
    check(dut, result=0x8000_0000, Z_flag=0, N_flag=1)
