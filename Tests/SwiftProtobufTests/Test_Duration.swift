// Tests/SwiftProtobufTests/Test_Duration.swift - Exercise well-known Duration type
//
// Copyright (c) 2014 - 2016 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/master/LICENSE.txt
//
// -----------------------------------------------------------------------------
///
/// Duration type includes custom JSON format, some hand-implemented convenience
/// methods, and arithmetic operators.
///
// -----------------------------------------------------------------------------

import XCTest
import SwiftProtobuf
import Foundation

class Test_Duration: XCTestCase, PBTestHelpers {
    typealias MessageTestType = Google_Protobuf_Duration

    func testJSON_encode() throws {
        assertJSONEncode("\"100s\"") { (o: inout MessageTestType) in
            o.seconds = 100
            o.nanos = 0
        }
        // Always prints exactly 3, 6, or 9 digits
        assertJSONEncode("\"100.100s\"") { (o: inout MessageTestType) in
            o.seconds = 100
            o.nanos = 100000000
        }
        assertJSONEncode("\"100.001s\"") { (o: inout MessageTestType) in
            o.seconds = 100
            o.nanos = 1000000
        }
        assertJSONEncode("\"100.000100s\"") { (o: inout MessageTestType) in
            o.seconds = 100
            o.nanos = 100000
        }
        assertJSONEncode("\"100.000001s\"") { (o: inout MessageTestType) in
            o.seconds = 100
            o.nanos = 1000
        }
        assertJSONEncode("\"100.000000100s\"") { (o: inout MessageTestType) in
            o.seconds = 100
            o.nanos = 100
        }
        assertJSONEncode("\"100.000000001s\"") { (o: inout MessageTestType) in
            o.seconds = 100
            o.nanos = 1
        }

        // Negative durations
        assertJSONEncode("\"-100.100s\"") { (o: inout MessageTestType) in
            o.seconds = -100
            o.nanos = -100000000
        }
    }

    func testJSON_decode() throws {
        assertJSONDecodeSucceeds("\"1.000000000s\"") {(o:MessageTestType) in
            o.seconds == 1 && o.nanos == 0
        }

        assertJSONDecodeSucceeds("\"-315576000000.999999999s\"") {(o:MessageTestType) in
            o.seconds == -315576000000 && o.nanos == -999999999
        }
        assertJSONDecodeFails("\"-315576000001s\"")
        assertJSONDecodeSucceeds("\"315576000000.999999999s\"") {(o:MessageTestType) in
            o.seconds == 315576000000 && o.nanos == 999999999
        }
        assertJSONDecodeFails("\"315576000001s\"")

        assertJSONDecodeFails("\"999999999999999999999.999999999s\"")
        assertJSONDecodeFails("\"\"")
        assertJSONDecodeFails("100.100s")
        assertJSONDecodeFails("\"-100.-100s\"")
        assertJSONDecodeFails("\"100.001\"")
        assertJSONDecodeFails("\"100.001sXXX\"")
    }

    func testSerializationFailure() throws {
        let maxOutOfRange = Google_Protobuf_Duration(seconds:-315576000001)
        XCTAssertThrowsError(try maxOutOfRange.serializeJSON())
        let minInRange = Google_Protobuf_Duration(seconds:-315576000000, nanos: -999999999)
        let _ = try minInRange.serializeJSON() // Assert does not throw
        let maxInRange = Google_Protobuf_Duration(seconds:315576000000, nanos: 999999999)
        let _ = try maxInRange.serializeJSON() // Assert does not throw
        let minOutOfRange = Google_Protobuf_Duration(seconds:315576000001)
        XCTAssertThrowsError(try minOutOfRange.serializeJSON())
    }

    // Make sure durations work correctly when stored in a field
    func testJSON_durationField() throws {
        do {
            let valid = try Conformance_TestAllTypes(json: "{\"optionalDuration\": \"1.001s\"}")
            XCTAssertEqual(valid.optionalDuration, Google_Protobuf_Duration(seconds: 1, nanos: 1000000))
        } catch {
            XCTFail("Should have decoded correctly")
        }

        XCTAssertThrowsError(try Conformance_TestAllTypes(json: "{\"optionalDuration\": \"-315576000001.000000000s\"}"))

        XCTAssertThrowsError(try Conformance_TestAllTypes(json: "{\"optionalDuration\": \"315576000001.000000000s\"}"))
        XCTAssertThrowsError(try Conformance_TestAllTypes(json: "{\"optionalDuration\": \"1.001\"}"))
    }

    func testFieldMember() throws {
        // Verify behavior when a duration appears as a field on a larger object
        let json1 = "{\"optionalDuration\": \"-315576000000.999999999s\"}"
        let m1 = try Conformance_TestAllTypes(json: json1)
        XCTAssertEqual(m1.optionalDuration.seconds, -315576000000)
        XCTAssertEqual(m1.optionalDuration.nanos, -999999999)

        let json2 = "{\"repeatedDuration\": [\"1.5s\", \"-1.5s\"]}"
        let expected2 = [Google_Protobuf_Duration(seconds:1, nanos:500000000), Google_Protobuf_Duration(seconds:-1, nanos:-500000000)]
        let actual2 = try Conformance_TestAllTypes(json: json2)
        XCTAssertEqual(actual2.repeatedDuration, expected2)
    }

    func testTranscode() throws {
        let jsonMax = "{\"optionalDuration\": \"315576000000.999999999s\"}"
        let parsedMax = try Conformance_TestAllTypes(json: jsonMax)
        XCTAssertEqual(parsedMax.optionalDuration.seconds, 315576000000)
        XCTAssertEqual(parsedMax.optionalDuration.nanos, 999999999)
        XCTAssertEqual(try parsedMax.serializeProtobuf(), Data(bytes:[234, 18, 13, 8, 128, 188, 174, 206, 151, 9, 16, 255, 147, 235, 220, 3]))
        let jsonMin = "{\"optionalDuration\": \"-315576000000.999999999s\"}"
        let parsedMin = try Conformance_TestAllTypes(json: jsonMin)
        XCTAssertEqual(parsedMin.optionalDuration.seconds, -315576000000)
        XCTAssertEqual(parsedMin.optionalDuration.nanos, -999999999)
        XCTAssertEqual(try parsedMin.serializeProtobuf(), Data(bytes:[234, 18, 22, 8, 128, 196, 209, 177, 232, 246, 255, 255, 255, 1, 16, 129, 236, 148, 163, 252, 255, 255, 255, 255, 1]))
    }

    func testConformance() throws {
        let tooSmall = try Conformance_TestAllTypes(protobuf: Data(bytes: [234, 18, 11, 8, 255, 195, 209, 177, 232, 246, 255, 255, 255, 1]))
        XCTAssertEqual(tooSmall.optionalDuration.seconds, -315576000001)
        XCTAssertEqual(tooSmall.optionalDuration.nanos, 0)
        XCTAssertThrowsError(try tooSmall.serializeJSON())

        let tooBig = try Conformance_TestAllTypes(protobuf: Data(bytes: [234, 18, 7, 8, 129, 188, 174, 206, 151, 9]))
        XCTAssertEqual(tooBig.optionalDuration.seconds, 315576000001)
        XCTAssertEqual(tooBig.optionalDuration.nanos, 0)
        XCTAssertThrowsError(try tooBig.serializeJSON())
    }

    func testBasicArithmetic() throws {
        let an2_n2 = Google_Protobuf_Duration(seconds: -2, nanos: -2)
        let an1_n1 = Google_Protobuf_Duration(seconds: -1, nanos: -1)
        let a0 = Google_Protobuf_Duration()
        let a1_1 = Google_Protobuf_Duration(seconds: 1, nanos: 1)
        let a2_2 = Google_Protobuf_Duration(seconds: 2, nanos: 2)
        let a3_3 = Google_Protobuf_Duration(seconds: 3, nanos: 3)
        let a4_4 = Google_Protobuf_Duration(seconds: 4, nanos: 4)
        XCTAssertEqual(a1_1, a0 + a1_1)
        XCTAssertEqual(a1_1, a1_1 + a0)
        XCTAssertEqual(a2_2, a1_1 + a1_1)
        XCTAssertEqual(a3_3, a1_1 + a2_2)
        XCTAssertEqual(a1_1, a4_4 - a3_3)
        XCTAssertEqual(an1_n1, a3_3 - a4_4)
        XCTAssertEqual(an1_n1, a3_3 + -a4_4)
        XCTAssertEqual(an1_n1, -a1_1)
        XCTAssertEqual(a2_2, -an2_n2)
        XCTAssertEqual(a2_2, -an2_n2)
    }

    func testArithmeticNormalizes() throws {
        // Addition normalizes the result
        XCTAssertEqual(Google_Protobuf_Duration() + Google_Protobuf_Duration(seconds: 0, nanos: 2000000001),
            Google_Protobuf_Duration(seconds: 2, nanos: 1))
        // Subtraction normalizes the result
        XCTAssertEqual(Google_Protobuf_Duration() - Google_Protobuf_Duration(seconds: 0, nanos: 2000000001),
            Google_Protobuf_Duration(seconds: -2, nanos: -1))
        // Unary minus normalizes the result
        XCTAssertEqual(-Google_Protobuf_Duration(seconds: 0, nanos: 2000000001),
            Google_Protobuf_Duration(seconds: -2, nanos: -1))
        XCTAssertEqual(-Google_Protobuf_Duration(seconds: 0, nanos: -2000000001),
            Google_Protobuf_Duration(seconds: 2, nanos: 1))
        XCTAssertEqual(-Google_Protobuf_Duration(seconds: 1, nanos: -2000000001),
            Google_Protobuf_Duration(seconds: 1, nanos: 1))
        XCTAssertEqual(-Google_Protobuf_Duration(seconds: -1, nanos: 2000000001),
            Google_Protobuf_Duration(seconds: -1, nanos: -1))
        XCTAssertEqual(-Google_Protobuf_Duration(seconds: -1, nanos: -2000000001),
            Google_Protobuf_Duration(seconds: 3, nanos: 1))
        XCTAssertEqual(-Google_Protobuf_Duration(seconds: 1, nanos: 2000000001),
            Google_Protobuf_Duration(seconds: -3, nanos: -1))
    }

    func testFloatLiteralConvertible() throws {
        var a: Google_Protobuf_Duration = 1.5
        XCTAssertEqual(a, Google_Protobuf_Duration(seconds: 1, nanos: 500000000))
        a = 100.000000001
        XCTAssertEqual(a, Google_Protobuf_Duration(seconds: 100, nanos: 1))

        var c = Conformance_TestAllTypes()
        c.optionalDuration = 100.000000001
        XCTAssertEqual(Data(bytes: [234, 18, 4, 8, 100, 16, 1]), try c.serializeProtobuf())
        XCTAssertEqual("{\"optionalDuration\":\"100.000000001s\"}", try c.serializeJSON())
    }

    // TODO: Exercise convenience methods that interoperate with Foundation time types.
}
