// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop.h for the primary calling header

#ifndef VERILATED_VTOP___024ROOT_H_
#define VERILATED_VTOP___024ROOT_H_  // guard

#include "verilated.h"


class Vtop__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtop___024root final {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(C_in,0,0);
    VL_IN8(ALU_SEL,3,0);
    VL_OUT8(C_out,0,0);
    VL_OUT8(Z_flag,0,0);
    VL_OUT8(N_flag,0,0);
    VL_OUT8(V_flag,0,0);
    CData/*0:0*/ ALU_32__DOT__C_in;
    CData/*3:0*/ ALU_32__DOT__ALU_SEL;
    CData/*0:0*/ ALU_32__DOT__C_out;
    CData/*0:0*/ ALU_32__DOT__Z_flag;
    CData/*0:0*/ ALU_32__DOT__N_flag;
    CData/*0:0*/ ALU_32__DOT__V_flag;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VstlPhaseResult;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __VicoPhaseResult;
    VL_IN(A,31,0);
    VL_IN(B,31,0);
    VL_OUT(Result,31,0);
    IData/*31:0*/ ALU_32__DOT__A;
    IData/*31:0*/ ALU_32__DOT__B;
    IData/*31:0*/ ALU_32__DOT__Result;
    QData/*32:0*/ ALU_32__DOT__A_ext;
    QData/*32:0*/ ALU_32__DOT__B_ext;
    QData/*32:0*/ ALU_32__DOT__Res33;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VicoTriggered;

    // INTERNAL VARIABLES
    Vtop__Syms* vlSymsp;
    const char* vlNamep;

    // PARAMETERS
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_ADD = 0U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_SUB = 1U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_NEG = 2U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_INC = 3U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_DEC = 4U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_AND = 5U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_OR = 6U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_XOR = 7U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_NOT = 8U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_RLC = 9U;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_RRC = 0x0aU;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_SETC = 0x0bU;
    static constexpr CData/*3:0*/ ALU_32__DOT__OP_CLRC = 0x0cU;

    // CONSTRUCTORS
    Vtop___024root(Vtop__Syms* symsp, const char* namep);
    ~Vtop___024root();
    VL_UNCOPYABLE(Vtop___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
