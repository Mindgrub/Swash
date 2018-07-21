//
//  CustomFontTests.swift
//  Swash_Tests
//
//  Created by Sam Francis on 7/21/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Swash

class CustomFontTests: XCTestCase {
    
    //MARK: - Of Size
    func testOfSize() {
        guard let font = GillSans.regular.of(size: 23) else {
            return XCTFail()
        }
        XCTAssertEqual(font.pointSize, 23)
        XCTAssertEqual(font.fontName, "GillSans")
    }
    
    func testInvalidOfSize() {
        XCTAssertNil(InvalidFont.doesNotExist.of(size: 12))
    }
    
    //MARK: - Of Text Style
    func testOfTextStyle() {
        XCTAssertNotNil(GillSans.boldItalic.of(textStyle: .title1))
    }
    
    func testOfTextStyleMax() {
        XCTAssertNotNil(GillSans.light.of(textStyle: .title2, maxSize: 30))
    }
    
    func testOfTextStyleMaxDefault() {
        XCTAssertNotNil(Papyrus.condensed.of(textStyle: .body, maxSize: 30, defaultSize: 17))
    }
    
    func testInvalidOfTextStyle() {
        XCTAssertNil(InvalidFont.doesNotExist.of(textStyle: .footnote))
    }
    
    //MARK: - Deprecated in iOS 11
    func testOfStyle() {
        XCTAssertNotNil(Papyrus.regular.of(style: .title3))
    }
    
    func testOfStyleMax() {
        XCTAssertNotNil(Papyrus.regular.of(style: .title3, maxSize: 10))
    }
    
    func testInvalidOfStyle() {
        XCTAssertNil(InvalidFont.doesNotExist.of(style: .caption1))
    }
    
    //MARK: - Log Boilerplate
    
    func testLogBoilerplate() {
        Swash.logBoilerplate()
    }
    
}
