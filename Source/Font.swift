import UIKit

/**
 A type that represents a font and can generate a `UIFont` object.
 */
public protocol Font: RawRepresentable, Hashable where Self.RawValue == String {
    
    /**
     Defines a mapping to convert one Font weight to another in the case that `UIAccessibility.isBoldTextEnabled` is true. Does not apply to watchOS.
     
     Example:
     ```
     var boldTextMapping: MyFont {
         switch self {
         case .regular: return .bold
         case .bold: return .black
         case .black: return self
         }
     }
     ```
     Now every regular `MyFont` instance will become bold if the user has "Bold Text" turned on in their device settings.
     
     If you'd like, you can observe `UIAccessibility.boldTextStatusDidChangeNotification` via `NotificationCenter` and set your fonts when that updates.
     */
    var boldTextMapping: Self { get }
    
    /**
     Defines a list of fonts to fall back to in the case that characters are used which the font does not support. Uses `UIFontDescriptor.AttributeName.cascadeList`.
     
     Example:
     ```
     var cascadeList: [CascadingFontProperties] {
         switch self {
         case .regular:
             return [.init(Damascus.regular)]
         case .bold:
             return [.init(Damascus.bold)]
     }
     ```
     */
    var cascadeList: [CascadingFontProperties] { get }
    
    func of(size: CGFloat) -> UIFont
    
    @available(iOS 11.0, watchOS 4.0, tvOS 11.0, *)
    func of(textStyle: UIFont.TextStyle, maxSize: CGFloat?, defaultSize: CGFloat?) -> UIFont
    
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    @available(watchOS, introduced: 2.0, deprecated: 4.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    @available(tvOS, introduced: 9.0, deprecated: 11.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    func of(style: UIFont.TextStyle, maxSize: CGFloat?) -> UIFont
}

public extension Font {
    
    var boldTextMapping: Self { self }
    var cascadeList: [CascadingFontProperties] { [] }
    
    /**
     Creates a font object of the specified size.
     
     The `rawValue` string is used to initialize the `UIFont` object with `UIFont(name:size:)`.
     
     If the font fails to initialize in a debug build (using `-Onone` optimization), a fatal error will be thrown. This is done to help catch boilerplate typos in development.
     
     Instead of using this method to get a font, it’s often more appropriate to use `of(textStyle:maxSize:defaultSize:)` because that method respects the user’s selected content size category.
     
     - Parameter size: The text size for the font.
     
     - Returns: A font object of the specified size.
     */
    func of(size: CGFloat) -> UIFont {
        let fontName: String
        let cascadeNames: [String]

        #if os(iOS) || os(tvOS)
        fontName = UIAccessibility.isBoldTextEnabled
            ? boldTextMapping.rawValue
            : rawValue
        
        cascadeNames = UIAccessibility.isBoldTextEnabled
            ? cascadeList.map { $0.boldFontName ?? $0.fontName }
            : cascadeList.map { $0.fontName }
        #else
        fontName = rawValue
        cascadeNames = cascadeList.map { $0.fontName }
        #endif
        
        guard let font = UIFont(name: fontName, size: size) else {
            // If font not found, crash debug builds.
            assertionFailure("Font not found: \(rawValue)")
            return .systemFont(ofSize: size)
        }
        
        let cascadeDescriptors = cascadeNames.map { UIFontDescriptor(fontAttributes: [.name: $0]) }
        let cascadedFontDescriptor = font.fontDescriptor.addingAttributes([.cascadeList: cascadeDescriptors])
        return UIFont(descriptor: cascadedFontDescriptor, size: size)
    }
    
    /**
     Creates a dynamic font object corresponding to the given parameters.
     
     Uses `UIFontMetrics` to initialize the dynamic font. If the font fails to initialize in a debug build (using `-Onone` optimization), a fatal error will be thrown. This is done to help catch boilerplate typos in development.
     
     If no default size is provided, the default specified in Apple's Human Interface Guidelines ([iOS](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/), [watchOS](https://developer.apple.com/design/human-interface-guidelines/watchos/visual-design/typography/), [tvOS](https://developer.apple.com/design/human-interface-guidelines/tvos/visual-design/typography/)) is used.
     
     - Parameters:
        - textStyle: The text style used to scale the text.
        - defaultSize: The base size used for text scaling. Corresponds to `UIContentSizeCategory.large`.
        - maxSize: The size which the text may not exceed.
     
     - Returns: A dynamic font object corresponding to the given parameters.
     */
    @available(iOS 11.0, watchOS 4.0, tvOS 11.0, *)
    func of(textStyle: UIFont.TextStyle, maxSize: CGFloat? = nil, defaultSize: CGFloat? = nil) -> UIFont {
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
            return of(size: 17)
        }
        
        let font = of(size: defaultSize)
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
     
     - Returns: A font object corresponding to the given parameters.
     */
    @available(iOS, introduced: 8.2, deprecated: 11.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    @available(watchOS, introduced: 2.0, deprecated: 4.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    @available(tvOS, introduced: 9.0, deprecated: 11.0, message: "Use `of(textStyle:maxSize:defaultSize:)` instead")
    func of(style: UIFont.TextStyle, maxSize: CGFloat? = nil) -> UIFont {
        let pointSize = UIFont.preferredFont(forTextStyle: style).pointSize
        
        if let maxSize = maxSize, pointSize > maxSize {
            return of(size: maxSize)
        } else {
            return of(size: pointSize)
        }
    }
}
