// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"

// Parameter definitions for Vtop___024root
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_ADD;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_SUB;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_NEG;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_INC;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_DEC;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_AND;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_OR;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_XOR;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_NOT;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_RLC;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_RRC;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_SETC;
constexpr CData/*3:0*/ Vtop___024root::ALU_32__DOT__OP_CLRC;


void Vtop___024root___ctor_var_reset(Vtop___024root* vlSelf);

Vtop___024root::Vtop___024root(Vtop__Syms* symsp, const char* namep)
 {
    vlSymsp = symsp;
    vlNamep = strdup(namep);
    // Reset structure values
    Vtop___024root___ctor_var_reset(this);
}

void Vtop___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vtop___024root::~Vtop___024root() {
    VL_DO_DANGLING(std::free(const_cast<char*>(vlNamep)), vlNamep);
}
