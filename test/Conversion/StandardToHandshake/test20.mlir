// NOTE: Assertions have been autogenerated by utils/update_mlir_test_checks.py
// RUN: circt-opt -lower-std-to-handshake %s | FileCheck %s
  func @min_reduction_tree(%arg0: index) {
// CHECK:       module {

// CHECK-LABEL:   handshake.func @min_reduction_tree(
// CHECK-SAME:                                       %[[VAL_0:.*]]: index, %[[VAL_1:.*]]: none, ...) -> none {
// CHECK:           %[[VAL_2:.*]] = "handshake.merge"(%[[VAL_0]]) : (index) -> index
// CHECK:           %[[VAL_3:.*]]:14 = "handshake.fork"(%[[VAL_2]]) {control = false} : (index) -> (index, index, index, index, index, index, index, index, index, index, index, index, index, index)
// CHECK:           %[[VAL_4:.*]]:3 = "handshake.fork"(%[[VAL_1]]) {control = true} : (none) -> (none, none, none)
// CHECK:           %[[VAL_5:.*]] = "handshake.constant"(%[[VAL_4]]#1) {value = 0 : index} : (none) -> index
// CHECK:           %[[VAL_6:.*]] = arith.cmpi slt, %[[VAL_3]]#12, %[[VAL_3]]#13 : index
// CHECK:           %[[VAL_7:.*]] = select %[[VAL_6]], %[[VAL_3]]#10, %[[VAL_3]]#11 : index
// CHECK:           %[[VAL_8:.*]]:2 = "handshake.fork"(%[[VAL_7]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_9:.*]] = arith.cmpi slt, %[[VAL_8]]#1, %[[VAL_3]]#9 : index
// CHECK:           %[[VAL_10:.*]] = select %[[VAL_9]], %[[VAL_8]]#0, %[[VAL_3]]#8 : index
// CHECK:           %[[VAL_11:.*]]:2 = "handshake.fork"(%[[VAL_10]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_12:.*]] = arith.cmpi slt, %[[VAL_11]]#1, %[[VAL_3]]#7 : index
// CHECK:           %[[VAL_13:.*]] = select %[[VAL_12]], %[[VAL_11]]#0, %[[VAL_3]]#6 : index
// CHECK:           %[[VAL_14:.*]]:2 = "handshake.fork"(%[[VAL_13]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_15:.*]] = arith.cmpi slt, %[[VAL_14]]#1, %[[VAL_3]]#5 : index
// CHECK:           %[[VAL_16:.*]] = select %[[VAL_15]], %[[VAL_14]]#0, %[[VAL_3]]#4 : index
// CHECK:           %[[VAL_17:.*]]:2 = "handshake.fork"(%[[VAL_16]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_18:.*]] = arith.cmpi slt, %[[VAL_17]]#1, %[[VAL_3]]#3 : index
// CHECK:           %[[VAL_19:.*]] = select %[[VAL_18]], %[[VAL_17]]#0, %[[VAL_3]]#2 : index
// CHECK:           %[[VAL_20:.*]]:2 = "handshake.fork"(%[[VAL_19]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_21:.*]] = arith.cmpi slt, %[[VAL_20]]#1, %[[VAL_3]]#1 : index
// CHECK:           %[[VAL_22:.*]] = select %[[VAL_21]], %[[VAL_20]]#0, %[[VAL_3]]#0 : index
// CHECK:           %[[VAL_23:.*]] = "handshake.constant"(%[[VAL_4]]#0) {value = 1 : index} : (none) -> index
// CHECK:           %[[VAL_24:.*]] = "handshake.branch"(%[[VAL_4]]#2) {control = true} : (none) -> none
// CHECK:           %[[VAL_25:.*]] = "handshake.branch"(%[[VAL_5]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_26:.*]] = "handshake.branch"(%[[VAL_22]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_27:.*]] = "handshake.branch"(%[[VAL_23]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_28:.*]] = "handshake.mux"(%[[VAL_29:.*]]#2, %[[VAL_30:.*]], %[[VAL_26]]) : (index, index, index) -> index
// CHECK:           %[[VAL_31:.*]]:2 = "handshake.fork"(%[[VAL_28]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_32:.*]] = "handshake.mux"(%[[VAL_29]]#1, %[[VAL_33:.*]], %[[VAL_27]]) : (index, index, index) -> index
// CHECK:           %[[VAL_34:.*]]:2 = "handshake.control_merge"(%[[VAL_35:.*]], %[[VAL_24]]) {control = true} : (none, none) -> (none, index)
// CHECK:           %[[VAL_29]]:3 = "handshake.fork"(%[[VAL_34]]#1) {control = false} : (index) -> (index, index, index)
// CHECK:           %[[VAL_36:.*]] = "handshake.mux"(%[[VAL_29]]#0, %[[VAL_37:.*]], %[[VAL_25]]) : (index, index, index) -> index
// CHECK:           %[[VAL_38:.*]]:2 = "handshake.fork"(%[[VAL_36]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_39:.*]] = arith.cmpi slt, %[[VAL_38]]#1, %[[VAL_31]]#1 : index
// CHECK:           %[[VAL_40:.*]]:4 = "handshake.fork"(%[[VAL_39]]) {control = false} : (i1) -> (i1, i1, i1, i1)
// CHECK:           %[[VAL_41:.*]], %[[VAL_42:.*]] = "handshake.conditional_branch"(%[[VAL_40]]#3, %[[VAL_31]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_42]]) : (index) -> ()
// CHECK:           %[[VAL_43:.*]], %[[VAL_44:.*]] = "handshake.conditional_branch"(%[[VAL_40]]#2, %[[VAL_32]]) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_44]]) : (index) -> ()
// CHECK:           %[[VAL_45:.*]], %[[VAL_46:.*]] = "handshake.conditional_branch"(%[[VAL_40]]#1, %[[VAL_34]]#0) {control = true} : (i1, none) -> (none, none)
// CHECK:           %[[VAL_47:.*]], %[[VAL_48:.*]] = "handshake.conditional_branch"(%[[VAL_40]]#0, %[[VAL_38]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_48]]) : (index) -> ()
// CHECK:           %[[VAL_49:.*]] = "handshake.merge"(%[[VAL_47]]) : (index) -> index
// CHECK:           %[[VAL_50:.*]] = "handshake.merge"(%[[VAL_43]]) : (index) -> index
// CHECK:           %[[VAL_51:.*]]:2 = "handshake.fork"(%[[VAL_50]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_52:.*]] = "handshake.merge"(%[[VAL_41]]) : (index) -> index
// CHECK:           %[[VAL_53:.*]]:2 = "handshake.control_merge"(%[[VAL_45]]) {control = true} : (none) -> (none, index)
// CHECK:           "handshake.sink"(%[[VAL_53]]#1) : (index) -> ()
// CHECK:           %[[VAL_54:.*]] = arith.addi %[[VAL_49]], %[[VAL_51]]#1 : index
// CHECK:           %[[VAL_33]] = "handshake.branch"(%[[VAL_51]]#0) {control = false} : (index) -> index
// CHECK:           %[[VAL_30]] = "handshake.branch"(%[[VAL_52]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_35]] = "handshake.branch"(%[[VAL_53]]#0) {control = true} : (none) -> none
// CHECK:           %[[VAL_37]] = "handshake.branch"(%[[VAL_54]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_55:.*]]:2 = "handshake.control_merge"(%[[VAL_46]]) {control = true} : (none) -> (none, index)
// CHECK:           "handshake.sink"(%[[VAL_55]]#1) : (index) -> ()
// CHECK:           handshake.return %[[VAL_55]]#0 : none
// CHECK:         }
// CHECK:       }

    %c0 = arith.constant 0 : index
    %0 = arith.cmpi slt, %arg0, %arg0 : index
    %1 = select %0, %arg0, %arg0 : index
    %2 = arith.cmpi slt, %1, %arg0 : index
    %3 = select %2, %1, %arg0 : index
    %4 = arith.cmpi slt, %3, %arg0 : index
    %5 = select %4, %3, %arg0 : index
    %6 = arith.cmpi slt, %5, %arg0 : index
    %7 = select %6, %5, %arg0 : index
    %8 = arith.cmpi slt, %7, %arg0 : index
    %9 = select %8, %7, %arg0 : index
    %10 = arith.cmpi slt, %9, %arg0 : index
    %11 = select %10, %9, %arg0 : index
    %c1 = arith.constant 1 : index
    br ^bb1(%c0 : index)
  ^bb1(%12: index):     // 2 preds: ^bb0, ^bb2
    %13 = arith.cmpi slt, %12, %11 : index
    cond_br %13, ^bb2, ^bb3
  ^bb2: // pred: ^bb1
    %14 = arith.addi %12, %c1 : index
    br ^bb1(%14 : index)
  ^bb3: // pred: ^bb1
    return
  }
