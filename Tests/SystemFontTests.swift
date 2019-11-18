//
//  SystemFontTests.swift
//  Swash_Tests
//
//  Created by Sam Francis on 7/21/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Swash

class SystemFontTests: XCTestCase {
    
    //MARK: - Of Size - Different Weights/Styles
    
    func testSystemPreferredOfSize() {
        let font = SystemFont.preferred.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-Regular")
    }
    
    func testSystemUltraLightOfSize() {
        let font = SystemFont.ultraLight.of(size: 14)
        XCTAssertEqual(font.pointSize, 14)
        XCTAssertEqual(font.fontName, ".SFUI-Ultralight")
    }
    
    func testSystemThinOfSize() {
        let font = SystemFont.thin.of(size: 11)
        XCTAssertEqual(font.pointSize, 11)
        XCTAssertEqual(font.fontName, ".SFUI-Thin")
    }
    
    func testSystemLightOfSize() {
        let font = SystemFont.light.of(size: 8)
        XCTAssertEqual(font.pointSize, 8)
        XCTAssertEqual(font.fontName, ".SFUI-Light")
    }
    
    func testSystemRegularOfSize() {
        let font = SystemFont.regular.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-Regular")
    }
    
    func testSystemMediumOfSize() {
        let font = SystemFont.medium.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-Medium")
    }
    
    func testSystemSemiboldOfSize() {
        let font = SystemFont.semibold.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-Semibold")
    }
    
    func testSystemBoldOfSize() {
        let font = SystemFont.bold.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-Bold")
    }
    
    func testSystemHeavyOfSize() {
        let font = SystemFont.heavy.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-Heavy")
    }
    
    func testSystemBlackOfSize() {
        let font = SystemFont.black.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-Black")
    }
    
    func testSystemItalicOfSize() {
        let font = SystemFont.italic.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-RegularItalic")
    }
    
    func testSystemSemiboldItalicOfSize() {
        let font = SystemFont.boldItalic.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        #if(iOS)
        XCTAssertEqual(font.fontName, ".SFUI-SemiboldItalic")
        #elseif (tvOS)
        XCTAssertEqual(font.fontName, ".SFUI-BoldItalic")
        #endif
    }
    
    func testSystemCondensedOfSize() {
        let font = SystemFont.condensed.of(size: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUITextCondensed-Regular")
    }
    
    
    //MARK: - Dynamic Type
    
    func testSystemPreferredOfTextStyle() {
        #if(iOS)
        XCTAssertEqual(SystemFont.preferred.of(textStyle: .body).fontName, ".SFUI")
        #elseif (tvOS)
        XCTAssertEqual(SystemFont.preferred.of(textStyle: .body).fontName, ".SFUI-Medium")
        #endif
    }
    
    func testSystemRegularOfTextStyle() {
        #if(iOS)
        XCTAssertEqual(SystemFont.italic.of(textStyle: .largeTitle).fontName, ".SFUIDisplay-Italic")
        #elseif (tvOS)
        XCTAssertEqual(SystemFont.italic.of(textStyle: .title1).fontName, ".SFUIDisplay-Italic")
        #endif
    }
    
    func testSystemItalicOfTextStyleMax() {
        #if(iOS)
        let font = SystemFont.italic.of(textStyle: .largeTitle, maxSize: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-Italic")
        #elseif (tvOS)
        let font = SystemFont.italic.of(textStyle: .title1, maxSize: 12)
        XCTAssertEqual(font.pointSize, 12)
        XCTAssertEqual(font.fontName, ".SFUI-Italic")
        #endif
    }
    
}

