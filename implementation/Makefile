
# Makefile for 32-bit RISC Processor Project
# Compatible with LibreLane flow

.PHONY: help sim synth clean librelane-setup librelane-run

help:
	@echo "32-bit RISC Processor - Build System"
	@echo "===================================="
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Simulation Targets:"
	@echo "  make sim              - Run iVerilog simulation"
	@echo "  make sim-modelsim     - Run ModelSim simulation"
	@echo "  make wave             - View simulation waveforms (gtkwave)"
	@echo ""
	@echo "Synthesis Targets:"
	@echo "  make synth            - Run Vivado synthesis"
	@echo "  make synth-yosys      - Run Yosys synthesis"
	@echo ""
	@echo "LibreLane Targets:"
	@echo "  make librelane-setup  - Setup LibreLane environment"
	@echo "  make librelane-run    - Run LibreLane flow"
	@echo "  make librelane-clean  - Clean LibreLane outputs"
	@echo ""
	@echo "Utility Targets:"
	@echo "  make clean            - Clean all build artifacts"
	@echo "  make check-yaml       - Validate YAML syntax"
	@echo "  make check-verilog    - Check Verilog syntax"

# ============================================================
# Simulation Targets
# ============================================================

sim: 
	@echo "Compiling with iVerilog..."
	iverilog -g2009 -Wall -o build/cpu_sim.vvp src/*.v sim/testbench.v
	@echo "Running simulation..."
	vvp build/cpu_sim.vvp
	@echo "Done! Check simulation.vcd for waveforms"

sim-modelsim:
	@echo "Compiling with ModelSim..."
	vlog -sv_std sv2017 src/*.v sim/testbench.v
	@echo "Running simulation..."
	vsim -c -do "run 1000ns; exit" work.CPU_SYSTEM_TB

wave:
	@if [ -f simulation.vcd ]; then \
		gtkwave simulation.vcd; \
	else \
		echo "Error: simulation.vcd not found. Run 'make sim' first."; \
	fi

# ============================================================
# Synthesis Targets
# ============================================================

synth:
	@echo "Running Vivado synthesis..."
	vivado -mode batch -source scripts/vivado_synth.tcl

synth-yosys:
	@echo "Running Yosys synthesis..."
	yosys -s scripts/yosys_synth.ys

# ============================================================
# LibreLane Targets
# ============================================================

librelane-setup:
	@echo "Setting up LibreLane environment..."
	@mkdir -p openlane/runs
	@cp config.yaml openlane/
	@echo "Setup complete. Ready for: make librelane-run"

librelane-run: librelane-setup
	@echo "Running LibreLane flow..."
	cd openlane && librelane config.yaml --pdk-root /usr/local/pdks

librelane-clean:
	@echo "Cleaning LibreLane outputs..."
	rm -rf openlane/runs/*

# ============================================================
# Validation Targets
# ============================================================

check-yaml:
	@echo "Validating YAML syntax..."
	python3 -c "import yaml; [yaml.safe_load(open(f)) for f in ['project.yaml', 'simulation.yaml', 'build.yaml', 'config.yaml']]"
	@echo "✓ All YAML files are valid"

check-verilog:
	@echo "Checking Verilog syntax..."
	iverilog -c verilog.cfg -o /dev/null src/*.v
	@echo "✓ Verilog syntax is valid"

# ============================================================
# Cleanup Targets
# ============================================================

clean:
	@echo "Cleaning build artifacts..."
	rm -f *.vvp *.vcd transcript work/*
	rm -rf build/* output/* work/
	rm -f openlane/runs/*
	@echo "Clean complete"

# ============================================================
# Directory Setup
# ============================================================

dirs:
	@mkdir -p src sim build output reports openlane/runs

.DEFAULT_GOAL := help
EOF
cat /mnt/user-data/outputs/Makefile
Sortie

# Makefile for 32-bit RISC Processor Project
# Compatible with LibreLane flow

.PHONY: help sim synth clean librelane-setup librelane-run

help:
	@echo "32-bit RISC Processor - Build System"
	@echo "===================================="
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Simulation Targets:"
	@echo "  make sim              - Run iVerilog simulation"
	@echo "  make sim-modelsim     - Run ModelSim simulation"
	@echo "  make wave             - View simulation waveforms (gtkwave)"
	@echo ""
	@echo "Synthesis Targets:"
	@echo "  make synth            - Run Vivado synthesis"
	@echo "  make synth-yosys      - Run Yosys synthesis"
	@echo ""
	@echo "LibreLane Targets:"
	@echo "  make librelane-setup  - Setup LibreLane environment"
	@echo "  make librelane-run    - Run LibreLane flow"
	@echo "  make librelane-clean  - Clean LibreLane outputs"
	@echo ""
	@echo "Utility Targets:"
	@echo "  make clean            - Clean all build artifacts"
	@echo "  make check-yaml       - Validate YAML syntax"
	@echo "  make check-verilog    - Check Verilog syntax"

# ============================================================
# Simulation Targets
# ============================================================

sim: 
	@echo "Compiling with iVerilog..."
	iverilog -g2009 -Wall -o build/cpu_sim.vvp src/*.v sim/testbench.v
	@echo "Running simulation..."
	vvp build/cpu_sim.vvp
	@echo "Done! Check simulation.vcd for waveforms"

sim-modelsim:
	@echo "Compiling with ModelSim..."
	vlog -sv_std sv2017 src/*.v sim/testbench.v
	@echo "Running simulation..."
	vsim -c -do "run 1000ns; exit" work.CPU_SYSTEM_TB

wave:
	@if [ -f simulation.vcd ]; then \
		gtkwave simulation.vcd; \
	else \
		echo "Error: simulation.vcd not found. Run 'make sim' first."; \
	fi

# ============================================================
# Synthesis Targets
# ============================================================

synth:
	@echo "Running Vivado synthesis..."
	vivado -mode batch -source scripts/vivado_synth.tcl

synth-yosys:
	@echo "Running Yosys synthesis..."
	yosys -s scripts/yosys_synth.ys

# ============================================================
# LibreLane Targets
# ============================================================

librelane-setup:
	@echo "Setting up LibreLane environment..."
	@mkdir -p openlane/runs
	@cp config.yaml openlane/
	@echo "Setup complete. Ready for: make librelane-run"

librelane-run: librelane-setup
	@echo "Running LibreLane flow..."
	cd openlane && librelane config.yaml --pdk-root /usr/local/pdks

librelane-clean:
	@echo "Cleaning LibreLane outputs..."
	rm -rf openlane/runs/*

# ============================================================
# Validation Targets
# ============================================================

check-yaml:
	@echo "Validating YAML syntax..."
	python3 -c "import yaml; [yaml.safe_load(open(f)) for f in ['project.yaml', 'simulation.yaml', 'build.yaml', 'config.yaml']]"
	@echo "✓ All YAML files are valid"

check-verilog:
	@echo "Checking Verilog syntax..."
	iverilog -c verilog.cfg -o /dev/null src/*.v
	@echo "✓ Verilog syntax is valid"

# ============================================================
# Cleanup Targets
# ============================================================

clean:
	@echo "Cleaning build artifacts..."
	rm -f *.vvp *.vcd transcript work/*
	rm -rf build/* output/* work/
	rm -f openlane/runs/*
	@echo "Clean complete"

# ============================================================
# Directory Setup
# ============================================================

dirs:
	@mkdir -p src sim build output reports openlane/runs

.DEFAULT_GOAL := help

