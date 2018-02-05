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
    func of(textStyle: UIFontTextStyle, defaultSize: CGFloat, maxSize: CGFloat?) -> UIFont?
    
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "In iOS 11+, you must specify a default size for custom fonts.")
    func of(textStyle: UIFontTextStyle, maxSize: CGFloat?) -> UIFont?
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
    public func of(textStyle: UIFontTextStyle, defaultSize: CGFloat, maxSize: CGFloat? = nil) -> UIFont? {
        guard let font = of(size: defaultSize) else { return nil }
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        
        if let maxSize = maxSize {
            return fontMetrics.scaledFont(for: font, maximumPointSize: maxSize)
        } else {
            return fontMetrics.scaledFont(for: font)
        }
    }
    
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "In iOS 11+, you must specify a default size for custom fonts.")
    public func of(textStyle: UIFontTextStyle, maxSize: CGFloat? = nil) -> UIFont? {
        let pointSize = UIFont.preferredFont(forTextStyle: textStyle).pointSize
        
        if let maxSize = maxSize, pointSize > maxSize {
            return of(size: maxSize)
        } else {
            return of(size: pointSize)
        }
    }
}
