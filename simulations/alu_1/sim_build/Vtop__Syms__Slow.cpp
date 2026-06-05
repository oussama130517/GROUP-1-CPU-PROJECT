// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vtop__pch.h"

Vtop__Syms::Vtop__Syms(VerilatedContext* contextp, const char* namep, Vtop* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup top module instance
    , TOP{this, namep}
{
    // Check resources
    Verilated::stackCheck(124);
    // Setup sub module instances
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-9);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
    // Setup scopes
    __Vscopep_ALU_32 = new VerilatedScope{this, "ALU_32", "ALU_32", "ALU_32", -9, VerilatedScope::SCOPE_MODULE};
    __Vscopep_TOP = new VerilatedScope{this, "TOP", "TOP", "<null>", 0, VerilatedScope::SCOPE_OTHER};
    // Set up scope hierarchy
    __Vhier.add(0, __Vscopep_ALU_32);
    // Setup export functions - final: 0
    // Setup export functions - final: 1
    // Setup public variables
    __Vscopep_ALU_32->varInsert("A", &(TOP.ALU_32__DOT__A), false, VLVT_UINT32, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,31,0);
    __Vscopep_ALU_32->varInsert("ALU_SEL", &(TOP.ALU_32__DOT__ALU_SEL), false, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("A_ext", &(TOP.ALU_32__DOT__A_ext), false, VLVT_UINT64, VLVD_NODIR|VLVF_PUB_RW|VLVF_CONTINUOUSLY, 0, 1 ,32,0);
    __Vscopep_ALU_32->varInsert("B", &(TOP.ALU_32__DOT__B), false, VLVT_UINT32, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,31,0);
    __Vscopep_ALU_32->varInsert("B_ext", &(TOP.ALU_32__DOT__B_ext), false, VLVT_UINT64, VLVD_NODIR|VLVF_PUB_RW|VLVF_CONTINUOUSLY, 0, 1 ,32,0);
    __Vscopep_ALU_32->varInsert("C_in", &(TOP.ALU_32__DOT__C_in), false, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 0);
    __Vscopep_ALU_32->varInsert("C_out", &(TOP.ALU_32__DOT__C_out), false, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 0);
    __Vscopep_ALU_32->varInsert("N_flag", &(TOP.ALU_32__DOT__N_flag), false, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW|VLVF_CONTINUOUSLY, 0, 0);
    __Vscopep_ALU_32->varInsert("OP_ADD", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_ADD))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_AND", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_AND))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_CLRC", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_CLRC))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_DEC", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_DEC))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_INC", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_INC))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_NEG", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_NEG))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_NOT", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_NOT))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_OR", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_OR))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_RLC", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_RLC))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_RRC", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_RRC))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_SETC", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_SETC))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_SUB", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_SUB))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("OP_XOR", const_cast<void*>(static_cast<const void*>(&(TOP.ALU_32__DOT__OP_XOR))), true, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_ALU_32->varInsert("Res33", &(TOP.ALU_32__DOT__Res33), false, VLVT_UINT64, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,32,0);
    __Vscopep_ALU_32->varInsert("Result", &(TOP.ALU_32__DOT__Result), false, VLVT_UINT32, VLVD_NODIR|VLVF_PUB_RW, 0, 1 ,31,0);
    __Vscopep_ALU_32->varInsert("V_flag", &(TOP.ALU_32__DOT__V_flag), false, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW, 0, 0);
    __Vscopep_ALU_32->varInsert("Z_flag", &(TOP.ALU_32__DOT__Z_flag), false, VLVT_UINT8, VLVD_NODIR|VLVF_PUB_RW|VLVF_CONTINUOUSLY, 0, 0);
    __Vscopep_TOP->varInsert("A", &(TOP.A), false, VLVT_UINT32, VLVD_IN|VLVF_PUB_RW, 0, 1 ,31,0);
    __Vscopep_TOP->varInsert("ALU_SEL", &(TOP.ALU_SEL), false, VLVT_UINT8, VLVD_IN|VLVF_PUB_RW, 0, 1 ,3,0);
    __Vscopep_TOP->varInsert("B", &(TOP.B), false, VLVT_UINT32, VLVD_IN|VLVF_PUB_RW, 0, 1 ,31,0);
    __Vscopep_TOP->varInsert("C_in", &(TOP.C_in), false, VLVT_UINT8, VLVD_IN|VLVF_PUB_RW, 0, 0);
    __Vscopep_TOP->varInsert("C_out", &(TOP.C_out), false, VLVT_UINT8, VLVD_OUT|VLVF_PUB_RW, 0, 0);
    __Vscopep_TOP->varInsert("N_flag", &(TOP.N_flag), false, VLVT_UINT8, VLVD_OUT|VLVF_PUB_RW|VLVF_CONTINUOUSLY, 0, 0);
    __Vscopep_TOP->varInsert("Result", &(TOP.Result), false, VLVT_UINT32, VLVD_OUT|VLVF_PUB_RW, 0, 1 ,31,0);
    __Vscopep_TOP->varInsert("V_flag", &(TOP.V_flag), false, VLVT_UINT8, VLVD_OUT|VLVF_PUB_RW, 0, 0);
    __Vscopep_TOP->varInsert("Z_flag", &(TOP.Z_flag), false, VLVT_UINT8, VLVD_OUT|VLVF_PUB_RW|VLVF_CONTINUOUSLY, 0, 0);
}

Vtop__Syms::~Vtop__Syms() {
    // Tear down scope hierarchy
    __Vhier.remove(0, __Vscopep_ALU_32);
    // Clear keys from hierarchy map after values have been removed
    __Vhier.clear();
    // Tear down scopes
    VL_DO_CLEAR(delete __Vscopep_ALU_32, __Vscopep_ALU_32 = nullptr);
    VL_DO_CLEAR(delete __Vscopep_TOP, __Vscopep_TOP = nullptr);
    // Tear down sub module instances
}
