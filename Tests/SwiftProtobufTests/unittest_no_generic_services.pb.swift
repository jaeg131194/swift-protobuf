/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: google/protobuf/unittest_no_generic_services.proto
 *
 */

//  Protocol Buffers - Google's data interchange format
//  Copyright 2008 Google Inc.  All rights reserved.
//  https://developers.google.com/protocol-buffers/
// 
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are
//  met:
// 
//      * Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//      * Redistributions in binary form must reproduce the above
//  copyright notice, this list of conditions and the following disclaimer
//  in the documentation and/or other materials provided with the
//  distribution.
//      * Neither the name of Google Inc. nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
// 
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
//  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

//  Author: kenton@google.com (Kenton Varda)

import Foundation
import SwiftProtobuf


enum Google_Protobuf_NoGenericServicesTest_TestEnum: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case foo // = 1

  init() {
    self = .foo
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 1: self = .foo
    default: return nil
    }
  }

  init?(name: String) {
    switch name {
    case "foo": self = .foo
    default: return nil
    }
  }

  init?(jsonName: String) {
    switch jsonName {
    case "FOO": self = .foo
    default: return nil
    }
  }

  init?(protoName: String) {
    switch protoName {
    case "FOO": self = .foo
    default: return nil
    }
  }

  var rawValue: Int {
    get {
      switch self {
      case .foo: return 1
      }
    }
  }

  var json: String {
    get {
      switch self {
      case .foo: return "\"FOO\""
      }
    }
  }

  var hashValue: Int { return rawValue }

  var debugDescription: String {
    get {
      switch self {
      case .foo: return ".foo"
      }
    }
  }

}

//  *_generic_services are false by default.

struct Google_Protobuf_NoGenericServicesTest_TestMessage: SwiftProtobuf.Message, SwiftProtobuf.Proto2Message, SwiftProtobuf.ExtensibleMessage, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf.ProtoNameProviding {
  public var swiftClassName: String {return "Google_Protobuf_NoGenericServicesTest_TestMessage"}
  public var protoMessageName: String {return "TestMessage"}
  public var protoPackageName: String {return "google.protobuf.no_generic_services_test"}
  public static let _protobuf_fieldNames: FieldNameMap = [
    1: .same(proto: "a", swift: "a"),
  ]

  public var unknown = SwiftProtobuf.UnknownStorage()

  private var _a: Int32? = nil
  var a: Int32 {
    get {return _a ?? 0}
    set {_a = newValue}
  }
  public var hasA: Bool {
    return _a != nil
  }
  public mutating func clearA() {
    return _a = nil
  }

  init() {}

  public mutating func _protoc_generated_decodeField<T: SwiftProtobuf.FieldDecoder>(setter: inout T, protoFieldNumber: Int) throws {
    switch protoFieldNumber {
    case 1: try setter.decodeSingularField(fieldType: SwiftProtobuf.ProtobufInt32.self, value: &_a)
    default: if (1000 <= protoFieldNumber && protoFieldNumber < 536870912) {
        try setter.decodeExtensionField(values: &extensionFieldValues, messageType: Google_Protobuf_NoGenericServicesTest_TestMessage.self, protoFieldNumber: protoFieldNumber)
      }
    }
  }

  public func _protoc_generated_traverse(visitor: SwiftProtobuf.Visitor) throws {
    if let v = _a {
      try visitor.visitSingularField(fieldType: SwiftProtobuf.ProtobufInt32.self, value: v, fieldNumber: 1)
    }
    try extensionFieldValues.traverse(visitor: visitor, start: 1000, end: 536870912)
    unknown.traverse(visitor: visitor)
  }

  public func _protoc_generated_isEqualTo(other: Google_Protobuf_NoGenericServicesTest_TestMessage) -> Bool {
    if _a != other._a {return false}
    if unknown != other.unknown {return false}
    if extensionFieldValues != other.extensionFieldValues {return false}
    return true
  }

  private var extensionFieldValues = SwiftProtobuf.ExtensionFieldValueSet()

  public mutating func setExtensionValue<F: SwiftProtobuf.ExtensionField>(ext: SwiftProtobuf.MessageExtension<F, Google_Protobuf_NoGenericServicesTest_TestMessage>, value: F.ValueType) {
    extensionFieldValues[ext.protoFieldNumber] = ext.set(value: value)
  }

  public mutating func clearExtensionValue<F: SwiftProtobuf.ExtensionField>(ext: SwiftProtobuf.MessageExtension<F, Google_Protobuf_NoGenericServicesTest_TestMessage>) {
    extensionFieldValues[ext.protoFieldNumber] = nil
  }

  public func getExtensionValue<F: SwiftProtobuf.ExtensionField>(ext: SwiftProtobuf.MessageExtension<F, Google_Protobuf_NoGenericServicesTest_TestMessage>) -> F.ValueType {
    if let fieldValue = extensionFieldValues[ext.protoFieldNumber] as? F {
      return fieldValue.value
    }
    return ext.defaultValue
  }

  public func hasExtensionValue<F: SwiftProtobuf.ExtensionField>(ext: SwiftProtobuf.MessageExtension<F, Google_Protobuf_NoGenericServicesTest_TestMessage>) -> Bool {
    return extensionFieldValues[ext.protoFieldNumber] is F
  }
  public func _protobuf_fieldNames(for number: Int) -> FieldNameMap.Names? {
    return Google_Protobuf_NoGenericServicesTest_TestMessage._protobuf_fieldNames.fieldNames(for: number) ?? extensionFieldValues.fieldNames(for: number)
  }
}

let Google_Protobuf_NoGenericServicesTest_Extensions_testExtension = SwiftProtobuf.MessageExtension<OptionalExtensionField<SwiftProtobuf.ProtobufInt32>, Google_Protobuf_NoGenericServicesTest_TestMessage>(protoFieldNumber: 1000, fieldNames: .same(proto: "[google.protobuf.no_generic_services_test.test_extension]", swift: "Google_Protobuf_NoGenericServicesTest_testExtension"), defaultValue: 0)

extension Google_Protobuf_NoGenericServicesTest_TestMessage {
  var Google_Protobuf_NoGenericServicesTest_testExtension: Int32 {
    get {return getExtensionValue(ext: Google_Protobuf_NoGenericServicesTest_Extensions_testExtension) ?? 0}
    set {setExtensionValue(ext: Google_Protobuf_NoGenericServicesTest_Extensions_testExtension, value: newValue)}
  }
  var hasGoogle_Protobuf_NoGenericServicesTest_testExtension: Bool {
    return hasExtensionValue(ext: Google_Protobuf_NoGenericServicesTest_Extensions_testExtension)
  }
  mutating func clearGoogle_Protobuf_NoGenericServicesTest_testExtension() {
    clearExtensionValue(ext: Google_Protobuf_NoGenericServicesTest_Extensions_testExtension)
  }
}

let Google_Protobuf_NoGenericServicesTest_UnittestNoGenericServices_Extensions: SwiftProtobuf.ExtensionSet = [
  Google_Protobuf_NoGenericServicesTest_Extensions_testExtension
]
