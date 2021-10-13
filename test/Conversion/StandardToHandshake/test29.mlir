// NOTE: Assertions have been autogenerated by utils/update_mlir_test_checks.py
// RUN: circt-opt -lower-std-to-handshake %s | FileCheck %s
func @load_store(memref<4x4xi32>, index, index) {
// CHECK-LABEL: handshake.func @load_store(
// CHECK-SAME:  %arg0: memref<4x4xi32>, %arg1: index, %arg2: index, %arg3: none, ...) -> none {
// CHECK:   %[[LDDATA_STNONE_LDNONE:.+]]:3 = "handshake.memory"(%[[STDATA_STIDX0_STIDX1:.+]]#0, %[[STDATA_STIDX0_STIDX1:.+]]#1, %[[STDATA_STIDX0_STIDX1:.+]]#2, %[[LDIDX0_LDIDX1:.+]]#0, %[[LDIDX0_LDIDX1:.+]]#1) {id = 0 : i32, ld_count = 1 : i32, lsq = false, st_count = 1 : i32, type = memref<4x4xi32>} : (i32, index, index, index, index) -> (i32, none, none)
// CHECK:   %[[STNONE_STNONE:.+]]:2 = "handshake.fork"(%[[LDDATA_STNONE_LDNONE:.+]]#1) {control = true} : (none) -> (none, none)

// The handling of input memref is a known issue.
// CHECK:   %2 = "handshake.merge"(%arg0) : (memref<4x4xi32>) -> memref<4x4xi32>
// CHECK:   "handshake.sink"(%2) : (memref<4x4xi32>) -> ()

// Fork index0 and index1 to load and store operation.
// CHECK:   %[[IDX0:.+]] = "handshake.merge"(%arg1) : (index) -> index
// CHECK:   %[[IDX0_IDX0:.+]]:2 = "handshake.fork"(%[[IDX0:.+]]) {control = false} : (index) -> (index, index)
// CHECK:   %[[IDX1:.+]] = "handshake.merge"(%arg2) : (index) -> index
// CHECK:   %[[IDX1_IDX1:.+]]:2 = "handshake.fork"(%[[IDX1:.+]]) {control = false} : (index) -> (index, index)

// Fork input control signal.
// CHECK:   %[[CTRL_CTRL_CTRL:.+]]:3 = "handshake.fork"(%arg3) {control = true} : (none) -> (none, none, none)
// CHECK:   %[[CTRL_CTRL:.+]]:2 = "handshake.fork"(%[[CTRL_CTRL_CTRL:.+]]#2) {control = true} : (none) -> (none, none)

// This indicates the completion of all operations.
// CHECK:   %[[STLDNONE_AND_CTRL:.+]] = "handshake.join"(%[[CTRL_CTRL:.+]]#1, %[[STNONE_STNONE:.+]]#1, %[[LDDATA_STNONE_LDNONE:.+]]#2) {control = true} : (none, none, none) -> none

// Store operation logic.
// CHECK:   %[[C1_I32:.+]] = "handshake.constant"(%[[CTRL_CTRL:.+]]#0) {value = 11 : i32} : (none) -> i32
// CHECK:   %[[STDATA_STIDX0_STIDX1:.+]]:3 = "handshake.store"(%[[C1_I32:.+]], %[[IDX0_IDX0:.+]]#1, %[[IDX1_IDX1:.+]]#1, %[[CTRL_CTRL_CTRL:.+]]#1) : (i32, index, index, none) -> (i32, index, index)

// This indicates the completion of store operation.
// CHECK:   %[[STNONE_AND_CTRL:.+]] = "handshake.join"(%[[CTRL_CTRL_CTRL:.+]]#0, %[[STNONE_STNONE:.+]]#0) {control = true} : (none, none) -> none

// Load operation logic.
// CHECK:   %[[LDDATA:.+]], %[[LDIDX0_LDIDX1:.+]]:2 = "handshake.load"(%[[IDX0_IDX0:.+]]#0, %[[IDX1_IDX1:.+]]#0, %[[LDDATA_STNONE_LDNONE:.+]]#0, %[[STNONE_AND_CTRL:.+]]) : (index, index, i32, none) -> (i32, index, index)

// Result of load operation is sinked.
// CHECK:   "handshake.sink"(%[[LDDATA:.+]]) : (i32) -> ()
// CHECK:   handshake.return %[[STLDNONE_AND_CTRL:.+]] : none
// CHECK: }

^bb0(%0: memref<4x4xi32>, %1: index, %2: index):
  %c1 = constant 11 : i32
  memref.store %c1, %0[%1, %2] : memref<4x4xi32>
  %3 = memref.load %0[%1, %2] : memref<4x4xi32>
  return
}
