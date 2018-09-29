//
//  Font.swift
//  Swash
//
//  Created by Sam Francis on 1/26/18.
//

import UIKit

/**
 A type that represents a font and can generate a `UIFont` object.
 */
public protocol Font: RawRepresentable where Self.RawValue == String {
    func of(size: CGFloat) -> UIFont?
    
    @available(iOS 11.0, watchOS 4.0, tvOS 11.0, *)
    func of(textStyle: UIFont.TextStyle, maxSize: CGFloat?, defaultSize: CGFloat?) -> UIFont?
    
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    @available(watchOS, introduced: 2.0, deprecated: 4.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    @available(tvOS, introduced: 9.0, deprecated: 11.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    func of(style: UIFont.TextStyle, maxSize: CGFloat?) -> UIFont?
}

public extension Font {
    /**
     Creates a font object of the specified size.
     
     The `rawValue` string is used to initialize the `UIFont` object with `UIFont(name:size:)`.
     
     If the font fails to initialize in a debug build (using `-Onone` optimization), a fatal error will be thrown. This is done to help catch boilerplate typos in development.
     
     Instead of using this method to get a font, it’s often more appropriate to use `of(textStyle:maxSize:defaultSize:)` because that method respects the user’s selected content size category.
     
     - Parameter size: The text size for the font.
     
     - Returns: A font object of the specified size. `nil` if the font cannot be initialized.
     */
    public func of(size: CGFloat) -> UIFont? {
        guard let font = UIFont(name: rawValue, size: size) else {
            // If font not found, crash debug builds
            assertionFailure("Font not found: \(rawValue)")
            return nil
        }
        return font
    }
    
    /**
     Creates a dynamic font object corresponding to the given parameters.
     
     Uses `UIFontMetrics` to initialize the dynamic font. If the font fails to initialize in a debug build (using `-Onone` optimization), a fatal error will be thrown. This is done to help catch boilerplate typos in development.
     
     If no default size is provided, the default specified in Apple's Human Interface Guidelines ([iOS](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/), [watchOS](https://developer.apple.com/design/human-interface-guidelines/watchos/visual-design/typography/), [tvOS](https://developer.apple.com/design/human-interface-guidelines/tvos/visual-design/typography/)) is used.
     
     - Parameters:
        - textStyle: The text style used to scale the text.
        - defaultSize: The base size used for text scaling. Corresponds to `UIContentSizeCategory.large`.
        - maxSize: The size which the text may not exceed.
     
     - Returns: A dynamic font object corresponding to the given parameters. `nil` if the font cannot be initialized.
     */
    @available(iOS 11.0, watchOS 4.0, tvOS 11.0, *)
    public func of(textStyle: UIFont.TextStyle,
                   maxSize: CGFloat? = nil,
                   defaultSize: CGFloat? = nil) -> UIFont? {
        // If no default size provided, use the default specified in Apple's HIG
        guard let defaultSize = defaultSize ?? defaultSizes[textStyle] else {
            assertionFailure("""
                Text style \(textStyle.rawValue) is not accounted for in Swash's
                default size dictionary 🤭. Either Apple's HIG has not specified a
                default size for \(textStyle.rawValue) for the device you are using,
                or it was recently added and this library needs to be updated (GitHub
                issues and pull requests are much appreciated!). In any case, at
                least for now, you must provide a default size to use this text style.
                """)
            return nil
        }
        
        guard let font = of(size: defaultSize) else { return nil }
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        
        if let maxSize = maxSize {
            return fontMetrics.scaledFont(for: font, maximumPointSize: maxSize)
        } else {
            return fontMetrics.scaledFont(for: font)
        }
    }
    
    /**
     Creates a font object sized based on the given parameters.
     
     `UIFontMetrics` didn't exist before iOS 11, so the built-in system font scaling is used to determine the size. If the font fails to initialize in a debug build (using `-Onone` optimization), a fatal error will be thrown. This is done to help catch boilerplate typos in development.
     
     - Parameters:
        - style: The text style used to scale the text.
        - maxSize: Size which the text may not exceed.
     
     - Returns: A font object corresponding to the given parameters. `nil` if the font cannot be initialized.
     */
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    @available(watchOS, introduced: 2.0, deprecated: 4.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    @available(tvOS, introduced: 9.0, deprecated: 11.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    public func of(style: UIFont.TextStyle, maxSize: CGFloat? = nil) -> UIFont? {
        let pointSize = UIFont.preferredFont(forTextStyle: style).pointSize
        
        if let maxSize = maxSize, pointSize > maxSize {
            return of(size: maxSize)
        } else {
            return of(size: pointSize)
        }
    }
}
