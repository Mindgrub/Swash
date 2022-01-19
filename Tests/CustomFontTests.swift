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
        let font = Avenir.roman.of(size: 23)
        XCTAssertEqual(font.pointSize, 23)
        XCTAssertEqual(font.fontName, "Avenir-Roman")
    }
    
    func testInvalidOfSize() {
        let font = InvalidFont.doesNotExist.of(size: 12)
        XCTAssertEqual(font.fontName, ".SFUI-Regular")
    }
    
    //MARK: - Dynamic Type
    
    func testOfTextStyle() {
        let font = Avenir.blackOblique.of(textStyle: .title1)
        XCTAssertEqual(font.fontName, "Avenir-BlackOblique")
    }
    
    func testOfTextStyleMax() {
        let font = Avenir.light.of(textStyle: .title2, maxSize: 30)
        XCTAssertEqual(font.fontName, "Avenir-Light")
    }
    
    func testOfTextStyleMaxDefault() {
        let font = Futura.condensedMedium.of(textStyle: .body, maxSize: 30, defaultSize: 17)
        XCTAssertEqual(font.fontName, "Futura-CondensedMedium")
    }
    
    func testInvalidOfTextStyle() {
        let font = InvalidFont.doesNotExist.of(textStyle: .footnote)
        XCTAssertEqual(font.fontName, ".SFUI-Regular")
    }
    
    //MARK: - Dynamic Type - Deprecated in iOS 11
    
    func testOfStyle() {
        let font = Futura.medium.of(textStyle: .title3)
        XCTAssertEqual(font.fontName, "Futura-Medium")
    }
    
    func testOfStyleMax() {
        let font = Futura.medium.of(textStyle: .title3, maxSize: 10)
        XCTAssertEqual(font.fontName, "Futura-Medium")
    }
    
    func testInvalidOfStyle() {
        let font = InvalidFont.doesNotExist.of(textStyle: .caption1)
        XCTAssertEqual(font.fontName, ".SFUI-Regular")
    }
    
    //MARK: - Log Boilerplate
    
    func testLogBoilerplate() {
        Swash.logBoilerplate()
    }
    
}
