// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"

void Vtop___024root___eval_triggers_vec__ico(Vtop___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_triggers_vec__ico\n"); );
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VicoTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VicoTriggered[0U]) 
                                     | (IData)((IData)(vlSelfRef.__VicoFirstIteration)));
}

bool Vtop___024root___trigger_anySet__ico(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___trigger_anySet__ico\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        if (in[n]) {
            return (1U);
        }
        n = ((IData)(1U) + n);
    } while ((1U > n));
    return (0U);
}

void Vtop___024root___ico_sequent__TOP__0(Vtop___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___ico_sequent__TOP__0\n"); );
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.ALU_32__DOT__C_in = vlSelfRef.C_in;
    vlSelfRef.ALU_32__DOT__ALU_SEL = vlSelfRef.ALU_SEL;
    vlSelfRef.ALU_32__DOT__A = vlSelfRef.A;
    vlSelfRef.ALU_32__DOT__B = vlSelfRef.B;
    vlSelfRef.ALU_32__DOT__A_ext = (QData)((IData)(vlSelfRef.ALU_32__DOT__A));
    vlSelfRef.ALU_32__DOT__B_ext = (QData)((IData)(vlSelfRef.ALU_32__DOT__B));
    vlSelfRef.ALU_32__DOT__Res33 = 0ULL;
    vlSelfRef.ALU_32__DOT__Result = 0U;
    vlSelfRef.ALU_32__DOT__C_out = 0U;
    vlSelfRef.ALU_32__DOT__V_flag = 0U;
    if ((8U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
        if ((4U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
            if ((2U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
                vlSelfRef.ALU_32__DOT__Result = 0U;
                vlSelfRef.ALU_32__DOT__C_out = 0U;
            } else if ((1U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
                vlSelfRef.ALU_32__DOT__Result = 0U;
                vlSelfRef.ALU_32__DOT__C_out = 0U;
            } else {
                vlSelfRef.ALU_32__DOT__Result = vlSelfRef.ALU_32__DOT__A;
                vlSelfRef.ALU_32__DOT__C_out = 0U;
            }
        } else if ((2U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
            if ((1U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
                vlSelfRef.ALU_32__DOT__Result = vlSelfRef.ALU_32__DOT__A;
                vlSelfRef.ALU_32__DOT__C_out = 1U;
            } else {
                vlSelfRef.ALU_32__DOT__Result = (((IData)(vlSelfRef.ALU_32__DOT__C_in) 
                                                  << 0x0000001fU) 
                                                 | (vlSelfRef.ALU_32__DOT__A 
                                                    >> 1U));
                vlSelfRef.ALU_32__DOT__C_out = (1U 
                                                & vlSelfRef.ALU_32__DOT__A);
            }
        } else if ((1U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
            vlSelfRef.ALU_32__DOT__Result = ((vlSelfRef.ALU_32__DOT__A 
                                              << 1U) 
                                             | (IData)(vlSelfRef.ALU_32__DOT__C_in));
            vlSelfRef.ALU_32__DOT__C_out = (vlSelfRef.ALU_32__DOT__A 
                                            >> 0x1fU);
        } else {
            vlSelfRef.ALU_32__DOT__Result = (~ vlSelfRef.ALU_32__DOT__A);
            vlSelfRef.ALU_32__DOT__C_out = 0U;
        }
    } else if ((4U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
        if ((2U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
            if ((1U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
                vlSelfRef.ALU_32__DOT__Result = (vlSelfRef.ALU_32__DOT__A 
                                                 ^ vlSelfRef.ALU_32__DOT__B);
                vlSelfRef.ALU_32__DOT__C_out = 0U;
            } else {
                vlSelfRef.ALU_32__DOT__Result = (vlSelfRef.ALU_32__DOT__A 
                                                 | vlSelfRef.ALU_32__DOT__B);
                vlSelfRef.ALU_32__DOT__C_out = 0U;
            }
        } else if ((1U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
            vlSelfRef.ALU_32__DOT__Result = (vlSelfRef.ALU_32__DOT__A 
                                             & vlSelfRef.ALU_32__DOT__B);
            vlSelfRef.ALU_32__DOT__C_out = 0U;
        } else {
            vlSelfRef.ALU_32__DOT__Res33 = (0x00000001ffffffffULL 
                                            & (vlSelfRef.ALU_32__DOT__A_ext 
                                               - 1ULL));
            vlSelfRef.ALU_32__DOT__Result = (IData)(vlSelfRef.ALU_32__DOT__Res33);
            vlSelfRef.ALU_32__DOT__V_flag = (0x80000000U 
                                             == vlSelfRef.ALU_32__DOT__A);
            vlSelfRef.ALU_32__DOT__C_out = (1U & (~ (IData)(
                                                            (vlSelfRef.ALU_32__DOT__Res33 
                                                             >> 0x20U))));
        }
    } else if ((2U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
        if ((1U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
            vlSelfRef.ALU_32__DOT__Res33 = (0x00000001ffffffffULL 
                                            & (1ULL 
                                               + vlSelfRef.ALU_32__DOT__A_ext));
            vlSelfRef.ALU_32__DOT__Result = (IData)(vlSelfRef.ALU_32__DOT__Res33);
            vlSelfRef.ALU_32__DOT__V_flag = (0x7fffffffU 
                                             == vlSelfRef.ALU_32__DOT__A);
            vlSelfRef.ALU_32__DOT__C_out = (1U & (IData)(
                                                         (vlSelfRef.ALU_32__DOT__Res33 
                                                          >> 0x20U)));
        } else {
            vlSelfRef.ALU_32__DOT__Res33 = (0x00000001ffffffffULL 
                                            & (1ULL 
                                               + (QData)((IData)(
                                                                 (~ vlSelfRef.ALU_32__DOT__A)))));
            vlSelfRef.ALU_32__DOT__Result = (IData)(vlSelfRef.ALU_32__DOT__Res33);
            vlSelfRef.ALU_32__DOT__V_flag = (0x80000000U 
                                             == vlSelfRef.ALU_32__DOT__A);
            vlSelfRef.ALU_32__DOT__C_out = (1U & (IData)(
                                                         (vlSelfRef.ALU_32__DOT__Res33 
                                                          >> 0x20U)));
        }
    } else if ((1U & (IData)(vlSelfRef.ALU_32__DOT__ALU_SEL))) {
        vlSelfRef.ALU_32__DOT__Res33 = (0x00000001ffffffffULL 
                                        & (vlSelfRef.ALU_32__DOT__A_ext 
                                           - vlSelfRef.ALU_32__DOT__B_ext));
        vlSelfRef.ALU_32__DOT__Result = (IData)(vlSelfRef.ALU_32__DOT__Res33);
        vlSelfRef.ALU_32__DOT__C_out = (1U & (~ (IData)(
                                                        (vlSelfRef.ALU_32__DOT__Res33 
                                                         >> 0x20U))));
        vlSelfRef.ALU_32__DOT__V_flag = (1U & ((((~ 
                                                  (vlSelfRef.ALU_32__DOT__A 
                                                   >> 0x1fU)) 
                                                 & (vlSelfRef.ALU_32__DOT__B 
                                                    >> 0x1fU)) 
                                                & (vlSelfRef.ALU_32__DOT__Result 
                                                   >> 0x1fU)) 
                                               | (((vlSelfRef.ALU_32__DOT__A 
                                                    >> 0x1fU) 
                                                   & (~ 
                                                      (vlSelfRef.ALU_32__DOT__B 
                                                       >> 0x1fU))) 
                                                  & (~ 
                                                     (vlSelfRef.ALU_32__DOT__Result 
                                                      >> 0x1fU)))));
    } else {
        vlSelfRef.ALU_32__DOT__Res33 = (0x00000001ffffffffULL 
                                        & (vlSelfRef.ALU_32__DOT__A_ext 
                                           + vlSelfRef.ALU_32__DOT__B_ext));
        vlSelfRef.ALU_32__DOT__Result = (IData)(vlSelfRef.ALU_32__DOT__Res33);
        vlSelfRef.ALU_32__DOT__C_out = (1U & (IData)(
                                                     (vlSelfRef.ALU_32__DOT__Res33 
                                                      >> 0x20U)));
        vlSelfRef.ALU_32__DOT__V_flag = (1U & ((((~ 
                                                  (vlSelfRef.ALU_32__DOT__A 
                                                   >> 0x1fU)) 
                                                 & (~ 
                                                    (vlSelfRef.ALU_32__DOT__B 
                                                     >> 0x1fU))) 
                                                & (vlSelfRef.ALU_32__DOT__Result 
                                                   >> 0x1fU)) 
                                               | (((vlSelfRef.ALU_32__DOT__A 
                                                    & vlSelfRef.ALU_32__DOT__B) 
                                                   >> 0x1fU) 
                                                  & (~ 
                                                     (vlSelfRef.ALU_32__DOT__Result 
                                                      >> 0x1fU)))));
    }
    vlSelfRef.C_out = vlSelfRef.ALU_32__DOT__C_out;
    vlSelfRef.V_flag = vlSelfRef.ALU_32__DOT__V_flag;
    vlSelfRef.Result = vlSelfRef.ALU_32__DOT__Result;
    vlSelfRef.ALU_32__DOT__Z_flag = (0U == vlSelfRef.ALU_32__DOT__Result);
    vlSelfRef.ALU_32__DOT__N_flag = (vlSelfRef.ALU_32__DOT__Result 
                                     >> 0x0000001fU);
    vlSelfRef.Z_flag = vlSelfRef.ALU_32__DOT__Z_flag;
    vlSelfRef.N_flag = vlSelfRef.ALU_32__DOT__N_flag;
}

void Vtop___024root___eval_ico(Vtop___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_ico\n"); );
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VicoTriggered[0U])) {
        Vtop___024root___ico_sequent__TOP__0(vlSelf);
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__ico(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

bool Vtop___024root___eval_phase__ico(Vtop___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__ico\n"); );
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VicoExecute;
    // Body
    Vtop___024root___eval_triggers_vec__ico(vlSelf);
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtop___024root___dump_triggers__ico(vlSelfRef.__VicoTriggered, "ico"s);
    }
#endif
    __VicoExecute = Vtop___024root___trigger_anySet__ico(vlSelfRef.__VicoTriggered);
    if (__VicoExecute) {
        Vtop___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VicoIterCount;
    // Body
    __VicoIterCount = 0U;
    vlSelfRef.__VicoFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00002710U < __VicoIterCount)))) {
#ifdef VL_DEBUG
            Vtop___024root___dump_triggers__ico(vlSelfRef.__VicoTriggered, "ico"s);
#endif
            VL_FATAL_MT("/home/user/alu_1/alu.v", 9, "", "DIDNOTCONVERGE: Input combinational region did not converge after '--converge-limit' of 10000 tries");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
        vlSelfRef.__VicoPhaseResult = Vtop___024root___eval_phase__ico(vlSelf);
        vlSelfRef.__VicoFirstIteration = 0U;
    } while (vlSelfRef.__VicoPhaseResult);
}

#ifdef VL_DEBUG
void Vtop___024root___eval_debug_assertions(Vtop___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_debug_assertions\n"); );
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (VL_UNLIKELY(((vlSelfRef.C_in & 0xfeU)))) {
        Verilated::overWidthError("C_in");
    }
    if (VL_UNLIKELY(((vlSelfRef.ALU_SEL & 0xf0U)))) {
        Verilated::overWidthError("ALU_SEL");
    }
}
#endif  // VL_DEBUG
