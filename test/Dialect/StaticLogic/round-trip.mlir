// RUN: circt-opt %s -verify-diagnostics | circt-opt -verify-diagnostics | FileCheck %s

func @test1(%arg0: memref<?xi32>) -> i32 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c10 = arith.constant 10 : index
  %c0_i32 = arith.constant 0 : i32
  // CHECK: staticlogic.pipeline.while
  // CHECK-SAME: iter_args(%arg1 = %c0, %arg2 = %c0_i32)
  // CHECK-SAME: (index, i32) -> i32
  // CHECK-SAME: {
  %0 = staticlogic.pipeline.while iter_args(%arg1 = %c0, %arg2 = %c0_i32) : (index, i32) -> i32 {
    %1 = arith.cmpi ult, %arg1, %c10 : index
    staticlogic.pipeline.register %1 : i1
  // CHECK: } do {
  } do {
    // CHECK: staticlogic.pipeline.stage {
    %1:2 = staticlogic.pipeline.stage  {
      %3 = arith.addi %arg1, %c1 : index
      %4 = memref.load %arg0[%arg1] : memref<?xi32>
      // CHECK: staticlogic.pipeline.register {{.+}} : {{.+}}
      // CHECK-NEXT: } : index, i32
      staticlogic.pipeline.register %3, %4 : index, i32
    } : index, i32
    %2 = staticlogic.pipeline.stage  {
      %3 = arith.addi %1#1, %arg2 : i32
      staticlogic.pipeline.register %3 : i32
    } : i32
    // CHECK: staticlogic.pipeline.terminator iter_args({{.+}}), results({{.+}}) : {{.+}}
    staticlogic.pipeline.terminator iter_args(%1#0, %2), results(%2) : (index, i32) -> i32
  }
  return %0 : i32
}

func @test2(%arg0: memref<?xi32>, %arg1: memref<?xi32>) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c3 = arith.constant 3 : index
  %c10 = arith.constant 10 : index
  // CHECK: staticlogic.pipeline.while
  // CHECK-SAME: iter_args(%arg2 = %c0)
  // CHECK-SAME: (index) -> ()
  staticlogic.pipeline.while iter_args(%arg2 = %c0) : (index) -> () {
    %0 = arith.cmpi ult, %arg2, %c10 : index
    staticlogic.pipeline.register %0 : i1
  } do {
    %0:4 = staticlogic.pipeline.stage  {
      %4 = arith.addi %arg2, %c1 : index
      %5 = memref.load %arg0[%arg2] : memref<?xi32>
      %6 = arith.cmpi uge, %arg2, %c3 : index
      staticlogic.pipeline.register %arg2, %4, %5, %6 : index, index, i32, i1
    } : index, index, i32, i1
    // CHECK: staticlogic.pipeline.stage when %0#3
    %1:3 = staticlogic.pipeline.stage when %0#3  {
      %4 = arith.subi %0#0, %c3 : index
      staticlogic.pipeline.register %0#2, %0#3, %4 : i32, i1, index
    } : i32, i1, index
    %2:4 = staticlogic.pipeline.stage when %1#1  {
      %4 = memref.load %arg0[%1#2] : memref<?xi32>
      staticlogic.pipeline.register %1#0, %1#1, %1#2, %4 : i32, i1, index, i32
    } : i32, i1, index, i32
    %3:3 = staticlogic.pipeline.stage when %2#1  {
      %4 = arith.addi %2#0, %2#3 : i32
      staticlogic.pipeline.register %2#1, %2#2, %4 : i1, index, i32
    } : i1, index, i32
    staticlogic.pipeline.stage when %3#0  {
      memref.store %3#2, %arg1[%3#1] : memref<?xi32>
      staticlogic.pipeline.register 
    }
    staticlogic.pipeline.terminator iter_args(%0#0), results() : (index) -> ()
  }
  return
}

func @test3(%arg0: memref<?xi32>) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c10 = arith.constant 10 : index
  %0 = memref.alloca() : memref<1xi32>
  %1 = memref.alloca() : memref<1xi32>
  %2 = memref.alloca() : memref<1xi32>
  // CHECK: staticlogic.pipeline.while
  // CHECK-SAME: iter_args(%arg1 = %c0)
  // CHECK-SAME: (index) -> ()
  staticlogic.pipeline.while iter_args(%arg1 = %c0) : (index) -> () {
    %3 = arith.cmpi ult, %arg1, %c10 : index
    staticlogic.pipeline.register %3 : i1
  } do {
    %3:5 = staticlogic.pipeline.stage  {
      %5 = arith.addi %arg1, %c1 : index
      %6 = memref.load %2[%c0] : memref<1xi32>
      %7 = memref.load %1[%c0] : memref<1xi32>
      %8 = memref.load %0[%c0] : memref<1xi32>
      %9 = memref.load %arg0[%arg1] : memref<?xi32>
      staticlogic.pipeline.register %5, %6, %7, %8, %9 : index, i32, i32, i32, i32
    } : index, i32, i32, i32, i32
    %4 = staticlogic.pipeline.stage  {
      memref.store %3#2, %2[%c0] : memref<1xi32>
      memref.store %3#3, %1[%c0] : memref<1xi32>
      %5 = arith.addi %3#1, %3#4 : i32
      staticlogic.pipeline.register %5 : i32
    } : i32
    staticlogic.pipeline.stage  {
      memref.store %4, %0[%c0] : memref<1xi32>
      staticlogic.pipeline.register 
    }
    staticlogic.pipeline.terminator iter_args(%3#0), results() : (index) -> ()
  }
  return
}

func @test4(%arg0: memref<?xi32>, %arg1: memref<?xi32>) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c10 = arith.constant 10 : index
  %c1_i32 = arith.constant 1 : i32
  // CHECK: staticlogic.pipeline.while
  // CHECK-SAME: iter_args(%arg2 = %c0)
  // CHECK-SAME: (index) -> ()
  staticlogic.pipeline.while iter_args(%arg2 = %c0) : (index) -> () {
    %0 = arith.cmpi ult, %arg2, %c10 : index
    staticlogic.pipeline.register %0 : i1
  } do {
    %0:2 = staticlogic.pipeline.stage  {
      %3 = arith.addi %arg2, %c1 : index
      %4 = memref.load %arg1[%arg2] : memref<?xi32>
      %5 = arith.index_cast %4 : i32 to index
      staticlogic.pipeline.register %3, %5 : index, index
    } : index, index
    %1:2 = staticlogic.pipeline.stage  {
      %3 = memref.load %arg0[%0#1] : memref<?xi32>
      staticlogic.pipeline.register %0#1, %3 : index, i32
    } : index, i32
    %2:2 = staticlogic.pipeline.stage  {
      %3 = arith.addi %1#1, %c1_i32 : i32
      staticlogic.pipeline.register %1#0, %3 : index, i32
    } : index, i32
    staticlogic.pipeline.stage  {
      memref.store %2#1, %arg0[%2#0] : memref<?xi32>
      staticlogic.pipeline.register 
    }
    staticlogic.pipeline.terminator iter_args(%0#0), results() : (index) -> ()
  }
  return
}

func @test5(%arg0: memref<?xi32>) {
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c10 = arith.constant 10 : index
  // CHECK: staticlogic.pipeline.while
  // CHECK-SAME: iter_args(%arg1 = %c2)
  // CHECK-SAME: (index) -> ()
  staticlogic.pipeline.while iter_args(%arg1 = %c2) : (index) -> () {
    %0 = arith.cmpi ult, %arg1, %c10 : index
    staticlogic.pipeline.register %0 : i1
  } do {
    %0 = staticlogic.pipeline.stage  {
      %2 = arith.subi %arg1, %c2 : index
      %3 = memref.load %arg0[%2] : memref<?xi32>
      staticlogic.pipeline.register %3 : i32
    } : i32
    %1:2 = staticlogic.pipeline.stage  {
      %2 = arith.subi %arg1, %c1 : index
      %3 = memref.load %arg0[%2] : memref<?xi32>
      %4 = arith.addi %arg1, %c1 : index
      staticlogic.pipeline.register %3, %4 : i32, index
    } : i32, index
    staticlogic.pipeline.stage  {
      %2 = arith.addi %0, %1#0 : i32
      memref.store %2, %arg0[%arg1] : memref<?xi32>
      staticlogic.pipeline.register 
    }
    staticlogic.pipeline.terminator iter_args(%1#1), results() : (index) -> ()
  }
  return
}
