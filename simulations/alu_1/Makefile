# ============================================================
#  Makefile – cocotb + Verilator testbench for ALU_32
#  Usage:
#    make          → run all tests
#    make clean    → remove build artefacts
#    make waves    → open VCD waveform in GTKWave (optional)
# ============================================================

# ── Simulator ────────────────────────────────────────────────
SIM        ?= verilator

# ── Top-level HDL module name ────────────────────────────────
TOPLEVEL   := ALU_32

# ── Source files ─────────────────────────────────────────────
VERILOG_SOURCES := $(PWD)/alu.v

# ── Python testbench module (no .py extension) ───────────────
MODULE     := test_alu_32

# ── Verilator flags ───────────────────────────────────────────
# --timing  : required by cocotb ≥ 2.0 with Verilator ≥ 5.x
# --trace   : generate VCD for waveform viewing
EXTRA_ARGS += --timing --trace --assert

# ── Language standard ─────────────────────────────────────────
COMPILE_ARGS += -sv

# ── Include cocotb's make rules ───────────────────────────────
include $(shell cocotb-config --makefiles)/Makefile.sim

# ── Convenience targets ───────────────────────────────────────
.PHONY: waves
waves:
	gtkwave dump.vcd &
