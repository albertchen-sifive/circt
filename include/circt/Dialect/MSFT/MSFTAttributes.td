//===- MSFTAttributes.td - MSFT attribute definitions ------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// "Forward-declare" these HW attributes rather than including or duplicating
// them here. This lets us to refer to them in ODS, but delegates to HW in C++.
// These are used to represent parameters to MSFTModuleExternOp.
def ParamDeclAttr : Attr<CPred<"$_self.isa<hw::ParamDeclAttr>()">>;
def ParamDeclArrayAttr : TypedArrayAttrBase<ParamDeclAttr, "parameter array">;

def PrimitiveType : I32EnumAttr<"PrimitiveType",
  "Type of device at physical location", [
    I32EnumAttrCase<"M20K", 1>,
    I32EnumAttrCase<"DSP", 2>,
  ]>;

class MSFT_Attr<string name, list<Trait> traits = [],
                string baseCppClass = "::mlir::Attribute">
    : AttrDef<MSFTDialect, name, traits, baseCppClass> {
  let mnemonic = ?;
}

def RootedInstancePath : MSFT_Attr<"RootedInstancePath"> {
  let summary = "A path through the instance hierarchy with the root module";
  let parameters = (ins
    "FlatSymbolRefAttr":$rootModule, ArrayRefParameter<"StringAttr">:$path);
}

def SwitchInstanceCase : MSFT_Attr<"SwitchInstanceCase"> {
  let summary = "A switch case in the SwitchInstance attribute";
  let parameters = (ins
    "RootedInstancePathAttr":$inst, "mlir::Attribute":$attr);
}

def SwitchInstance : MSFT_Attr<"SwitchInstance"> {
  let summary = "Select an attribute to be use based on the instance";
  let mnemonic = "switch.inst";
  let parameters = (ins
    ArrayRefParameter<"SwitchInstanceCaseAttr">:$cases);

  let extraClassDeclaration = [{
    Attribute lookup(RootedInstancePathAttr);
  }];
}

def PhysLocation : MSFT_Attr<"PhysLocation"> {
  let summary = "Descibes a physical location on a device";
  let description = [{
    Annotate a particular entity within an op with the location of the device
    on an FPGA to which it should mapped. The coordinates in this attribute
    are absolute locations on the device, so if there are two instances of a
    module with this annotation incorrect results will be generated. How to
    solve this is a more general, open problem.
  }];
  let mnemonic = "physloc";
  let parameters = (ins
    "PrimitiveTypeAttr":$primitiveType,
    "uint64_t":$x, "uint64_t":$y, "uint64_t":$num);
}
