//
//  Font.swift
//  Swash
//
//  Created by Sam Francis on 1/26/18.
//

import UIKit

public protocol Font {
    func of(size: CGFloat) -> UIFont?
    
    @available(iOS 11.0, *)
    func of(textStyle: UIFontTextStyle, defaultSize: CGFloat) -> UIFont?
    
    @available(iOS 11.0, *)
    func of(textStyle: UIFontTextStyle, defaultSize: CGFloat, maxSize: CGFloat) -> UIFont?
    
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "In iOS 11+, you must specify a default size for custom FontTypes")
    func of(textStyle: UIFontTextStyle) -> UIFont?
    
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "In iOS 11+, you must specify a default size for custom FontTypes")
    func of(textStyle: UIFontTextStyle, maxSize: CGFloat) -> UIFont?
}

public extension Font where Self: RawRepresentable, Self.RawValue == String {
    public func of(size: CGFloat) -> UIFont? {
        guard let font = UIFont(name: rawValue, size: size) else {
            debugLog("Font not found: \(rawValue)")
            return nil
        }
        return font
    }
    
    @available(iOS 11.0, *)
    public func of(textStyle: UIFontTextStyle, defaultSize: CGFloat) -> UIFont? {
        guard let font = of(size: defaultSize) else { return nil }
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
    
    @available(iOS 11.0, *)
    public func of(textStyle: UIFontTextStyle, defaultSize: CGFloat, maxSize: CGFloat) -> UIFont? {
        guard let font = of(size: defaultSize) else { return nil }
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font, maximumPointSize: maxSize)
    }
    
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "In iOS 11+, you must specify a default size for custom FontTypes")
    public func of(textStyle: UIFontTextStyle) -> UIFont? {
        return of(size: UIFont.preferredFont(forTextStyle: textStyle).pointSize)
    }
    
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "In iOS 11+, you must specify a default size for custom FontTypes")
    public func of(textStyle: UIFontTextStyle, maxSize: CGFloat) -> UIFont? {
        guard let font = of(textStyle: textStyle) else { return nil }
        if font.pointSize <= maxSize {
            return font
        } else {
            return of(size: maxSize)
        }
    }
}
