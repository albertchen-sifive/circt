// NOTE: Assertions have been autogenerated by utils/update_mlir_test_checks.py
// RUN: circt-opt -lower-std-to-handshake %s | FileCheck %s
func @more_imperfectly_nested_loops() {
// CHECK:       module {

// CHECK-LABEL:   handshake.func @more_imperfectly_nested_loops(
// CHECK-SAME:                                                  %[[VAL_0:.*]]: none, ...) -> none {
// CHECK:           %[[VAL_1:.*]] = "handshake.branch"(%[[VAL_0]]) {control = true} : (none) -> none
// CHECK:           %[[VAL_2:.*]]:2 = "handshake.control_merge"(%[[VAL_1]]) {control = true} : (none) -> (none, index)
// CHECK:           %[[VAL_3:.*]]:3 = "handshake.fork"(%[[VAL_2]]#0) {control = true} : (none) -> (none, none, none)
// CHECK:           "handshake.sink"(%[[VAL_2]]#1) : (index) -> ()
// CHECK:           %[[VAL_4:.*]] = "handshake.constant"(%[[VAL_3]]#1) {value = 0 : index} : (none) -> index
// CHECK:           %[[VAL_5:.*]] = "handshake.constant"(%[[VAL_3]]#0) {value = 42 : index} : (none) -> index
// CHECK:           %[[VAL_6:.*]] = "handshake.branch"(%[[VAL_3]]#2) {control = true} : (none) -> none
// CHECK:           %[[VAL_7:.*]] = "handshake.branch"(%[[VAL_4]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_8:.*]] = "handshake.branch"(%[[VAL_5]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_9:.*]] = "handshake.mux"(%[[VAL_10:.*]]#1, %[[VAL_11:.*]], %[[VAL_8]]) : (index, index, index) -> index
// CHECK:           %[[VAL_12:.*]]:2 = "handshake.fork"(%[[VAL_9]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_13:.*]]:2 = "handshake.control_merge"(%[[VAL_14:.*]], %[[VAL_6]]) {control = true} : (none, none) -> (none, index)
// CHECK:           %[[VAL_10]]:2 = "handshake.fork"(%[[VAL_13]]#1) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_15:.*]] = "handshake.mux"(%[[VAL_10]]#0, %[[VAL_16:.*]], %[[VAL_7]]) : (index, index, index) -> index
// CHECK:           %[[VAL_17:.*]]:2 = "handshake.fork"(%[[VAL_15]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_18:.*]] = arith.cmpi slt, %[[VAL_17]]#1, %[[VAL_12]]#1 : index
// CHECK:           %[[VAL_19:.*]]:3 = "handshake.fork"(%[[VAL_18]]) {control = false} : (i1) -> (i1, i1, i1)
// CHECK:           %[[VAL_20:.*]], %[[VAL_21:.*]] = "handshake.conditional_branch"(%[[VAL_19]]#2, %[[VAL_12]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_21]]) : (index) -> ()
// CHECK:           %[[VAL_22:.*]], %[[VAL_23:.*]] = "handshake.conditional_branch"(%[[VAL_19]]#1, %[[VAL_13]]#0) {control = true} : (i1, none) -> (none, none)
// CHECK:           %[[VAL_24:.*]], %[[VAL_25:.*]] = "handshake.conditional_branch"(%[[VAL_19]]#0, %[[VAL_17]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_25]]) : (index) -> ()
// CHECK:           %[[VAL_26:.*]] = "handshake.merge"(%[[VAL_24]]) : (index) -> index
// CHECK:           %[[VAL_27:.*]] = "handshake.merge"(%[[VAL_20]]) : (index) -> index
// CHECK:           %[[VAL_28:.*]]:2 = "handshake.control_merge"(%[[VAL_22]]) {control = true} : (none) -> (none, index)
// CHECK:           "handshake.sink"(%[[VAL_28]]#1) : (index) -> ()
// CHECK:           %[[VAL_29:.*]] = "handshake.branch"(%[[VAL_26]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_30:.*]] = "handshake.branch"(%[[VAL_27]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_31:.*]] = "handshake.branch"(%[[VAL_28]]#0) {control = true} : (none) -> none
// CHECK:           %[[VAL_32:.*]] = "handshake.merge"(%[[VAL_29]]) : (index) -> index
// CHECK:           %[[VAL_33:.*]] = "handshake.merge"(%[[VAL_30]]) : (index) -> index
// CHECK:           %[[VAL_34:.*]]:2 = "handshake.control_merge"(%[[VAL_31]]) {control = true} : (none) -> (none, index)
// CHECK:           %[[VAL_35:.*]]:3 = "handshake.fork"(%[[VAL_34]]#0) {control = true} : (none) -> (none, none, none)
// CHECK:           "handshake.sink"(%[[VAL_34]]#1) : (index) -> ()
// CHECK:           %[[VAL_36:.*]] = "handshake.constant"(%[[VAL_35]]#1) {value = 7 : index} : (none) -> index
// CHECK:           %[[VAL_37:.*]] = "handshake.constant"(%[[VAL_35]]#0) {value = 56 : index} : (none) -> index
// CHECK:           %[[VAL_38:.*]] = "handshake.branch"(%[[VAL_32]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_39:.*]] = "handshake.branch"(%[[VAL_33]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_40:.*]] = "handshake.branch"(%[[VAL_35]]#2) {control = true} : (none) -> none
// CHECK:           %[[VAL_41:.*]] = "handshake.branch"(%[[VAL_36]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_42:.*]] = "handshake.branch"(%[[VAL_37]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_43:.*]] = "handshake.mux"(%[[VAL_44:.*]]#3, %[[VAL_45:.*]], %[[VAL_42]]) : (index, index, index) -> index
// CHECK:           %[[VAL_46:.*]]:2 = "handshake.fork"(%[[VAL_43]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_47:.*]] = "handshake.mux"(%[[VAL_44]]#2, %[[VAL_48:.*]], %[[VAL_38]]) : (index, index, index) -> index
// CHECK:           %[[VAL_49:.*]] = "handshake.mux"(%[[VAL_44]]#1, %[[VAL_50:.*]], %[[VAL_39]]) : (index, index, index) -> index
// CHECK:           %[[VAL_51:.*]]:2 = "handshake.control_merge"(%[[VAL_52:.*]], %[[VAL_40]]) {control = true} : (none, none) -> (none, index)
// CHECK:           %[[VAL_44]]:4 = "handshake.fork"(%[[VAL_51]]#1) {control = false} : (index) -> (index, index, index, index)
// CHECK:           %[[VAL_53:.*]] = "handshake.mux"(%[[VAL_44]]#0, %[[VAL_54:.*]], %[[VAL_41]]) : (index, index, index) -> index
// CHECK:           %[[VAL_55:.*]]:2 = "handshake.fork"(%[[VAL_53]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_56:.*]] = arith.cmpi slt, %[[VAL_55]]#1, %[[VAL_46]]#1 : index
// CHECK:           %[[VAL_57:.*]]:5 = "handshake.fork"(%[[VAL_56]]) {control = false} : (i1) -> (i1, i1, i1, i1, i1)
// CHECK:           %[[VAL_58:.*]], %[[VAL_59:.*]] = "handshake.conditional_branch"(%[[VAL_57]]#4, %[[VAL_46]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_59]]) : (index) -> ()
// CHECK:           %[[VAL_60:.*]], %[[VAL_61:.*]] = "handshake.conditional_branch"(%[[VAL_57]]#3, %[[VAL_47]]) {control = false} : (i1, index) -> (index, index)
// CHECK:           %[[VAL_62:.*]], %[[VAL_63:.*]] = "handshake.conditional_branch"(%[[VAL_57]]#2, %[[VAL_49]]) {control = false} : (i1, index) -> (index, index)
// CHECK:           %[[VAL_64:.*]], %[[VAL_65:.*]] = "handshake.conditional_branch"(%[[VAL_57]]#1, %[[VAL_51]]#0) {control = true} : (i1, none) -> (none, none)
// CHECK:           %[[VAL_66:.*]], %[[VAL_67:.*]] = "handshake.conditional_branch"(%[[VAL_57]]#0, %[[VAL_55]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_67]]) : (index) -> ()
// CHECK:           %[[VAL_68:.*]] = "handshake.merge"(%[[VAL_66]]) : (index) -> index
// CHECK:           %[[VAL_69:.*]] = "handshake.merge"(%[[VAL_58]]) : (index) -> index
// CHECK:           %[[VAL_70:.*]] = "handshake.merge"(%[[VAL_60]]) : (index) -> index
// CHECK:           %[[VAL_71:.*]] = "handshake.merge"(%[[VAL_62]]) : (index) -> index
// CHECK:           %[[VAL_72:.*]]:2 = "handshake.control_merge"(%[[VAL_64]]) {control = true} : (none) -> (none, index)
// CHECK:           %[[VAL_73:.*]]:2 = "handshake.fork"(%[[VAL_72]]#0) {control = true} : (none) -> (none, none)
// CHECK:           "handshake.sink"(%[[VAL_72]]#1) : (index) -> ()
// CHECK:           %[[VAL_74:.*]] = "handshake.constant"(%[[VAL_73]]#0) {value = 2 : index} : (none) -> index
// CHECK:           %[[VAL_75:.*]] = arith.addi %[[VAL_68]], %[[VAL_74]] : index
// CHECK:           %[[VAL_45]] = "handshake.branch"(%[[VAL_69]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_48]] = "handshake.branch"(%[[VAL_70]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_50]] = "handshake.branch"(%[[VAL_71]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_52]] = "handshake.branch"(%[[VAL_73]]#1) {control = true} : (none) -> none
// CHECK:           %[[VAL_54]] = "handshake.branch"(%[[VAL_75]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_76:.*]] = "handshake.merge"(%[[VAL_61]]) : (index) -> index
// CHECK:           %[[VAL_77:.*]] = "handshake.merge"(%[[VAL_63]]) : (index) -> index
// CHECK:           %[[VAL_78:.*]]:2 = "handshake.control_merge"(%[[VAL_65]]) {control = true} : (none) -> (none, index)
// CHECK:           "handshake.sink"(%[[VAL_78]]#1) : (index) -> ()
// CHECK:           %[[VAL_79:.*]] = "handshake.branch"(%[[VAL_76]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_80:.*]] = "handshake.branch"(%[[VAL_77]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_81:.*]] = "handshake.branch"(%[[VAL_78]]#0) {control = true} : (none) -> none
// CHECK:           %[[VAL_82:.*]] = "handshake.merge"(%[[VAL_79]]) : (index) -> index
// CHECK:           %[[VAL_83:.*]] = "handshake.merge"(%[[VAL_80]]) : (index) -> index
// CHECK:           %[[VAL_84:.*]]:2 = "handshake.control_merge"(%[[VAL_81]]) {control = true} : (none) -> (none, index)
// CHECK:           %[[VAL_85:.*]]:3 = "handshake.fork"(%[[VAL_84]]#0) {control = true} : (none) -> (none, none, none)
// CHECK:           "handshake.sink"(%[[VAL_84]]#1) : (index) -> ()
// CHECK:           %[[VAL_86:.*]] = "handshake.constant"(%[[VAL_85]]#1) {value = 18 : index} : (none) -> index
// CHECK:           %[[VAL_87:.*]] = "handshake.constant"(%[[VAL_85]]#0) {value = 37 : index} : (none) -> index
// CHECK:           %[[VAL_88:.*]] = "handshake.branch"(%[[VAL_82]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_89:.*]] = "handshake.branch"(%[[VAL_83]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_90:.*]] = "handshake.branch"(%[[VAL_85]]#2) {control = true} : (none) -> none
// CHECK:           %[[VAL_91:.*]] = "handshake.branch"(%[[VAL_86]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_92:.*]] = "handshake.branch"(%[[VAL_87]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_93:.*]] = "handshake.mux"(%[[VAL_94:.*]]#3, %[[VAL_95:.*]], %[[VAL_92]]) : (index, index, index) -> index
// CHECK:           %[[VAL_96:.*]]:2 = "handshake.fork"(%[[VAL_93]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_97:.*]] = "handshake.mux"(%[[VAL_94]]#2, %[[VAL_98:.*]], %[[VAL_88]]) : (index, index, index) -> index
// CHECK:           %[[VAL_99:.*]] = "handshake.mux"(%[[VAL_94]]#1, %[[VAL_100:.*]], %[[VAL_89]]) : (index, index, index) -> index
// CHECK:           %[[VAL_101:.*]]:2 = "handshake.control_merge"(%[[VAL_102:.*]], %[[VAL_90]]) {control = true} : (none, none) -> (none, index)
// CHECK:           %[[VAL_94]]:4 = "handshake.fork"(%[[VAL_101]]#1) {control = false} : (index) -> (index, index, index, index)
// CHECK:           %[[VAL_103:.*]] = "handshake.mux"(%[[VAL_94]]#0, %[[VAL_104:.*]], %[[VAL_91]]) : (index, index, index) -> index
// CHECK:           %[[VAL_105:.*]]:2 = "handshake.fork"(%[[VAL_103]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_106:.*]] = arith.cmpi slt, %[[VAL_105]]#1, %[[VAL_96]]#1 : index
// CHECK:           %[[VAL_107:.*]]:5 = "handshake.fork"(%[[VAL_106]]) {control = false} : (i1) -> (i1, i1, i1, i1, i1)
// CHECK:           %[[VAL_108:.*]], %[[VAL_109:.*]] = "handshake.conditional_branch"(%[[VAL_107]]#4, %[[VAL_96]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_109]]) : (index) -> ()
// CHECK:           %[[VAL_110:.*]], %[[VAL_111:.*]] = "handshake.conditional_branch"(%[[VAL_107]]#3, %[[VAL_97]]) {control = false} : (i1, index) -> (index, index)
// CHECK:           %[[VAL_112:.*]], %[[VAL_113:.*]] = "handshake.conditional_branch"(%[[VAL_107]]#2, %[[VAL_99]]) {control = false} : (i1, index) -> (index, index)
// CHECK:           %[[VAL_114:.*]], %[[VAL_115:.*]] = "handshake.conditional_branch"(%[[VAL_107]]#1, %[[VAL_101]]#0) {control = true} : (i1, none) -> (none, none)
// CHECK:           %[[VAL_116:.*]], %[[VAL_117:.*]] = "handshake.conditional_branch"(%[[VAL_107]]#0, %[[VAL_105]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_117]]) : (index) -> ()
// CHECK:           %[[VAL_118:.*]] = "handshake.merge"(%[[VAL_116]]) : (index) -> index
// CHECK:           %[[VAL_119:.*]] = "handshake.merge"(%[[VAL_108]]) : (index) -> index
// CHECK:           %[[VAL_120:.*]] = "handshake.merge"(%[[VAL_110]]) : (index) -> index
// CHECK:           %[[VAL_121:.*]] = "handshake.merge"(%[[VAL_112]]) : (index) -> index
// CHECK:           %[[VAL_122:.*]]:2 = "handshake.control_merge"(%[[VAL_114]]) {control = true} : (none) -> (none, index)
// CHECK:           %[[VAL_123:.*]]:2 = "handshake.fork"(%[[VAL_122]]#0) {control = true} : (none) -> (none, none)
// CHECK:           "handshake.sink"(%[[VAL_122]]#1) : (index) -> ()
// CHECK:           %[[VAL_124:.*]] = "handshake.constant"(%[[VAL_123]]#0) {value = 3 : index} : (none) -> index
// CHECK:           %[[VAL_125:.*]] = arith.addi %[[VAL_118]], %[[VAL_124]] : index
// CHECK:           %[[VAL_95]] = "handshake.branch"(%[[VAL_119]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_98]] = "handshake.branch"(%[[VAL_120]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_100]] = "handshake.branch"(%[[VAL_121]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_102]] = "handshake.branch"(%[[VAL_123]]#1) {control = true} : (none) -> none
// CHECK:           %[[VAL_104]] = "handshake.branch"(%[[VAL_125]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_126:.*]] = "handshake.merge"(%[[VAL_111]]) : (index) -> index
// CHECK:           %[[VAL_127:.*]] = "handshake.merge"(%[[VAL_113]]) : (index) -> index
// CHECK:           %[[VAL_128:.*]]:2 = "handshake.control_merge"(%[[VAL_115]]) {control = true} : (none) -> (none, index)
// CHECK:           %[[VAL_129:.*]]:2 = "handshake.fork"(%[[VAL_128]]#0) {control = true} : (none) -> (none, none)
// CHECK:           "handshake.sink"(%[[VAL_128]]#1) : (index) -> ()
// CHECK:           %[[VAL_130:.*]] = "handshake.constant"(%[[VAL_129]]#0) {value = 1 : index} : (none) -> index
// CHECK:           %[[VAL_131:.*]] = arith.addi %[[VAL_126]], %[[VAL_130]] : index
// CHECK:           %[[VAL_11]] = "handshake.branch"(%[[VAL_127]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_14]] = "handshake.branch"(%[[VAL_129]]#1) {control = true} : (none) -> none
// CHECK:           %[[VAL_16]] = "handshake.branch"(%[[VAL_131]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_132:.*]]:2 = "handshake.control_merge"(%[[VAL_23]]) {control = true} : (none) -> (none, index)
// CHECK:           "handshake.sink"(%[[VAL_132]]#1) : (index) -> ()
// CHECK:           handshake.return %[[VAL_132]]#0 : none
// CHECK:         }
// CHECK:       }

^bb0:
  br ^bb1
^bb1:	// pred: ^bb0
  %c0 = arith.constant 0 : index
  %c42 = arith.constant 42 : index
  br ^bb2(%c0 : index)
^bb2(%0: index):	// 2 preds: ^bb1, ^bb11
  %1 = arith.cmpi slt, %0, %c42 : index
  cond_br %1, ^bb3, ^bb12
^bb3:	// pred: ^bb2
  br ^bb4
^bb4:	// pred: ^bb3
  %c7 = arith.constant 7 : index
  %c56 = arith.constant 56 : index
  br ^bb5(%c7 : index)
^bb5(%2: index):	// 2 preds: ^bb4, ^bb6
  %3 = arith.cmpi slt, %2, %c56 : index
  cond_br %3, ^bb6, ^bb7
^bb6:	// pred: ^bb5
  %c2 = arith.constant 2 : index
  %4 = arith.addi %2, %c2 : index
  br ^bb5(%4 : index)
^bb7:	// pred: ^bb5
  br ^bb8
^bb8:	// pred: ^bb7
  %c18 = arith.constant 18 : index
  %c37 = arith.constant 37 : index
  br ^bb9(%c18 : index)
^bb9(%5: index):	// 2 preds: ^bb8, ^bb10
  %6 = arith.cmpi slt, %5, %c37 : index
  cond_br %6, ^bb10, ^bb11
^bb10:	// pred: ^bb9
  %c3 = arith.constant 3 : index
  %7 = arith.addi %5, %c3 : index
  br ^bb9(%7 : index)
^bb11:	// pred: ^bb9
  %c1 = arith.constant 1 : index
  %8 = arith.addi %0, %c1 : index
  br ^bb2(%8 : index)
^bb12:	// pred: ^bb2
  return
}
