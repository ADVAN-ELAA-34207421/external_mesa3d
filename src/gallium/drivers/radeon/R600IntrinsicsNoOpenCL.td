//===-- R600Intrinsics.td - R600 Instrinsic defs -------*- tablegen -*-----===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// R600 Intrinsic Definitions
//
//===----------------------------------------------------------------------===//

let TargetPrefix = "R600", isTarget = 1 in {
  def int_R600_load_input : Intrinsic<[llvm_float_ty], [llvm_i32_ty], [IntrNoMem]>;
}

let TargetPrefix = "r600", isTarget = 1 in {

class R600ReadPreloadRegisterIntrinsic<string name>
  : Intrinsic<[llvm_i32_ty], [], [IntrNoMem]>,
    GCCBuiltin<name>;

multiclass R600ReadPreloadRegisterIntrinsic_xyz<string prefix> {
  def _x : R600ReadPreloadRegisterIntrinsic<!strconcat(prefix, "_x")>;
  def _y : R600ReadPreloadRegisterIntrinsic<!strconcat(prefix, "_y")>;
  def _z : R600ReadPreloadRegisterIntrinsic<!strconcat(prefix, "_z")>;
}

defm int_r600_read_global_size : R600ReadPreloadRegisterIntrinsic_xyz <
                                       "__builtin_r600_read_global_size">;
defm int_r600_read_local_size : R600ReadPreloadRegisterIntrinsic_xyz <
                                       "__builtin_r600_read_local_size">;
defm int_r600_read_ngroups : R600ReadPreloadRegisterIntrinsic_xyz <
                                       "__builtin_r600_read_ngroups">;
defm int_r600_read_tgid : R600ReadPreloadRegisterIntrinsic_xyz <
                                       "__builtin_r600_read_tgid">;
defm int_r600_read_tidig : R600ReadPreloadRegisterIntrinsic_xyz <
                                       "__builtin_r600_read_tidig">;
} // End TargetPrefix = "r600"
