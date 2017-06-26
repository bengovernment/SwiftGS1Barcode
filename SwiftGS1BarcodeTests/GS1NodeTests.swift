//
//  GS1NodeTests.swift
//  SwiftGS1Barcode
//
//  Created by Toni Hoffmann on 26.06.17.
//  Copyright © 2017 Toni Hoffmann. All rights reserved.
//

import XCTest

@testable import SwiftGS1Barcode
class GS1NodeTests: XCTestCase {
    
    func testInitIdMaxLength() {
        let node = GS1Node("id", length: 1)
        XCTAssertEqual(node.identifier, "id")
        XCTAssertEqual(node.maxLength, 1)
        XCTAssertEqual(node.type, nil)
    }
    
    func testInitIdMaxLengthType() {
        let node = GS1Node("id", length: 1, type: .Int)
        XCTAssertEqual(node.identifier, "id")
        XCTAssertEqual(node.maxLength, 1)
        XCTAssertEqual(node.type, .Int)
    }
    
    func testInitIdMaxLengthTypeDynamicLength() {
        let node = GS1Node("id", length: 1, type: .Int, dynamicLength: true)
        XCTAssertEqual(node.identifier, "id")
        XCTAssertEqual(node.maxLength, 1)
        XCTAssertEqual(node.type, .Int)
        XCTAssertEqual(node.dynamicLength, true)
    }
}
