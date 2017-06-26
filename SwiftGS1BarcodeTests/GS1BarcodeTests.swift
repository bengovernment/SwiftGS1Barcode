//
//  GS1BarcodeTests.swift
//  SwiftGS1Barcode
//
//  Created by Toni Hoffmann on 26.06.17.
//  Copyright © 2017 Toni Hoffmann. All rights reserved.
//

import XCTest
@testable import SwiftGS1Barcode

class GS1BarcodeTests: XCTestCase {
    var barcode: GS1Barcode!
    override func setUp() {
        super.setUp()
        // Should parse 01, 30, 17, 10, is a LOT, no Serial
        barcode = GS1Barcode(raw: "01101234670420223005\u{1d}172101311010022247")
    }
    
    override func tearDown() {
        super.tearDown()
        barcode = nil
    }
    
    func testExample() {
        let barcode = GS1Barcode(raw: "01001234670210133001\u{1D}2110066600")
        XCTAssert(barcode.validate())
        
        XCTAssertNotNil(barcode.gtin)
        XCTAssertEqual(barcode.gtin, "00123467021013")
        XCTAssertNil(barcode.lotNumber)
        XCTAssertNotNil(barcode.amount)
        XCTAssertNotNil(barcode.serialNumber)
        
        XCTAssertEqual(barcode.amount, 1)
        XCTAssertEqual(barcode.gtin, "00123467021013")
        XCTAssertEqual(barcode.serialNumber, "10066600")
    }
    
    func testEmptyBarcode(){
        barcode = GS1Barcode(raw: "")
        
        XCTAssertNil(barcode.gtin)
        XCTAssertNil(barcode.lotNumber)
        XCTAssertNil(barcode.expirationDate)
        XCTAssertNil(barcode.serialNumber)
        XCTAssertNil(barcode.amount)
        XCTAssertNil(barcode.gtinIndicatorDigit)
        XCTAssertEqual(barcode.raw, "")
        XCTAssert(!barcode.validate())
    }
    
    func testGTIN() {
        XCTAssertNotNil(barcode.gtin)
        XCTAssertNotEqual(barcode.gtin, "")
        XCTAssertEqual(barcode.gtin, "10123467042022")
    }
    
    func testGETINIndicator(){
        XCTAssertNotNil(barcode.gtinIndicatorDigit)
        XCTAssertEqual(barcode.gtinIndicatorDigit, 1)
    }
    
    func testLot(){
        XCTAssertNotNil(barcode.lotNumber)
        XCTAssertEqual(barcode.lotNumber, "10022247")
    }
    
    func testSerial(){
        XCTAssertNil(barcode.serialNumber)
    }
    
    func testQuantity(){
        XCTAssertNotNil(barcode.amount)
        XCTAssertEqual(barcode.amount, 5)
    }
    
    func testExpirationDate(){
        XCTAssertNotNil(barcode.nodes.expirationDateNode.originalValue)
        XCTAssertNotNil(barcode.expirationDate)
        XCTAssertEqual(barcode.expirationDate, NSDate.from(year: 2021, month: 1, day: 31))
    }
    
    
    func testGETINIndicatorDifferentValue(){
        barcode = GS1Barcode(raw: "01201234670420223005\u{1d}172101311010022247")
        XCTAssertNotNil(barcode.gtinIndicatorDigit)
        XCTAssertEqual(barcode.gtinIndicatorDigit, 2)
    }
    func testGETINIndicatorEmpty(){
        barcode = GS1Barcode(raw: "01001234670420223005\u{1d}172101311010022247")
        XCTAssertNotNil(barcode.gtinIndicatorDigit)
        XCTAssertEqual(barcode.gtinIndicatorDigit, 0)
    }
    func testGETINIndicatorEmptyBarcode(){
        barcode = GS1Barcode(raw: "")
        XCTAssertNil(barcode.gtinIndicatorDigit)
    }
    
    func testValidate(){
        XCTAssert(barcode.validate())
    }
    
    func testValidateNewBarcode(){
        let b = GS1Barcode()
        XCTAssertFalse(b.validate())
    }
    func testValidateEmptyBarcode(){
        let b = GS1Barcode(raw: "")
        XCTAssertFalse(b.validate())
    }
    
    
    // Experimental Support
    
//    func testserialShippingContainerCodeNode(){
//        //var serialShippingContainerCodeNode = GS1Node("0", length: 18, type: .String)
//        barcode = GS1Barcode(raw: "02123456789012345678901234567890")
//        XCTAssertNotNil(barcode.serialShippingContainerCode)
//        // XCTAssertEqual(barcode.serialShippingContainerCode, "")
//    }
//    func testgtinOfContainedTradeItemsNode(){
//        //var gtinOfContainedTradeItemsNode = GS1Node("2", length: 14, type: .String)
//        barcode = GS1Barcode(raw: "22123456789012345678901234567890")
//        XCTAssertNotNil(barcode.gtinOfContainedTradeItems)
//        // XCTAssertEqual(barcode.gtinOfContainedTradeItems, "")
//    }
    func testproductionDateNode(){
        //var productionDateNode = GS1Node(dateIdentifier: "11")
        barcode = GS1Barcode(raw: "11210110")
        XCTAssertNotNil(barcode.productionDate)
        XCTAssertEqual(barcode.productionDate, NSDate.from(year: 2021, month: 1, day: 10))
    }
    func testdueDateNode(){
        //var dueDateNode = GS1Node(dateIdentifier: "12")
        barcode = GS1Barcode(raw: "12210110")
        XCTAssertNotNil(barcode.dueDate)
        XCTAssertEqual(barcode.dueDate, NSDate.from(year: 2021, month: 1, day: 10))
    }
    func testpackagingDateNode(){
        //var packagingDateNode = GS1Node(dateIdentifier: "13")
        barcode = GS1Barcode(raw: "13210110")
        XCTAssertNotNil(barcode.packagingDate)
        XCTAssertEqual(barcode.packagingDate, NSDate.from(year: 2021, month: 1, day: 10))
    }
    func testbestBeforeDateNode(){
        //var bestBeforeDateNode = GS1Node(dateIdentifier: "15")
        barcode = GS1Barcode(raw: "15210110")
        XCTAssertNotNil(barcode.bestBeforeDate)
        XCTAssertEqual(barcode.bestBeforeDate, NSDate.from(year: 2021, month: 1, day: 10))
    }
    func testproductVariantNode(){
        //var productVariantNode = GS1Node("20", length: 2, type: .String)
        barcode = GS1Barcode(raw: "2023456789012345678901234567890")
        XCTAssertNotNil(barcode.productVariant)
        // XCTAssertEqual(barcode.productVariant, "")
    }
  
    func testsecondaryDataFieldsNode(){
        //var secondaryDataFieldsNode = GS1Node("22", length:29, type: .String, dynamicLength:true)
        barcode = GS1Barcode(raw: "22123456789012345678901234567890")
        XCTAssertNotNil(barcode.secondaryDataFields)
        // XCTAssertEqual(barcode.secondaryDataFields, "")
    }
    func testnumberOfUnitsContainedNode(){
        //var numberOfUnitsContainedNode = GS1Node("37", length:8, type: .String, dynamicLength:true)
        barcode = GS1Barcode(raw: "37123456789012345678901234567890")
        XCTAssertNotNil(barcode.numberOfUnitsContained)
        // XCTAssertEqual(barcode.numberOfUnitsContained, "")
    }
}
