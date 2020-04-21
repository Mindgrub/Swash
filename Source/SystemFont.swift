import UIKit

/**
 A type that represents the system font and can generate a `UIFont` object.
 */
public enum SystemFont {
    /**
     Represents the "preferred" system font.
     
     For this case, `of(size:)` returns the direct result of `UIFont.systemFont(ofSize:)`. In addition, `of(textStyle:maxSize:)` returns the direct result of `UIFont.preferredFont(forTextStyle:)` when `maxSize` is `nil`. This is the only case which allows for labels and text views to automatically resize if `adjustsFontForContentSizeCategory` is `true`.
     */
    case preferred
    
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
    
    #if os(iOS) || os(tvOS)
    /**
     Represents the system font generated with symbolic traits `[.traitCondensed]`.
     
     Findings: On watchOS, this translates to `.SFCompactText-Heavy` up to 19pt and `.SFCompactText-Black` for larger sizes. So I've excluded this option from watchOS.
     */
    case condensed
    #endif
    
    /**
     Represents the system font generated with symbolic traits `[.traitItalic, .traitBold]`.
     
     Findings: On iOS, this translates to `.SFUIText-SemiboldItalic`. On tvOS, it translates to `.SFUIText-BoldItalic`. On watchOS, `.SFCompactText-BoldItalic`.
    */
    case boldItalic
    
    /**
     Represents the system font generated with symbolic traits `[.traitItalic]`.
     */
    case italic
    
    
    private enum Style {
        case weight(UIFont.Weight)
        case traits(UIFontDescriptor.SymbolicTraits)
    }
    
    private var style: Style? {
        switch self {
        case .preferred: return nil
            
        case .ultraLight: return .weight(.ultraLight)
        case .thin: return .weight(.thin)
        case .light: return .weight(.light)
        case .regular: return .weight(.regular)
        case .medium: return .weight(.medium)
        case .semibold: return .weight(.semibold)
        case .bold: return .weight(.bold)
        case .heavy: return .weight(.heavy)
        case .black: return .weight(.black)
            
        #if os(iOS) || os(tvOS)
        case .condensed: return .traits([.traitCondensed])
        #endif
        case .boldItalic: return .traits([.traitItalic, .traitBold])
        case .italic: return .traits([.traitItalic])
        }
    }
    
    /**
     Creates a system font object of the specified size.
     
     Instead of using this method to get a font, it’s often more appropriate to use `of(textStyle:maxSize:)` because that method respects the user’s selected content size category.
     
     - Parameter size: The text size for the font.
     
     - Returns: A system font object of the specified size.
     */
    public func of(size: CGFloat) -> UIFont {
        guard let style = style else {
            return .systemFont(ofSize: size)
        }
        
        switch style {
        case .weight(let weight):
            return .systemFont(ofSize: size, weight: weight)
        case .traits(let traits):
            if let descriptor = UIFont.systemFont(ofSize: size, weight: .regular).fontDescriptor.withSymbolicTraits(traits) {
                return UIFont(descriptor: descriptor, size: size)
            } else {
                // Should never be reached
                return .systemFont(ofSize: size)
            }
        }
    }
    
    /**
     Creates a dynamic font object sized based on the given parameters.
     
     When used to set the text value of a label or text view, set `adjustsFontForContentSizeCategory` to `true`.
     
     - Important: The `adjustsFontForContentSizeCategory` property on `UILabel`, `UITextView`, etc. only works for the `preferred` weight with a nil `maxSize` value. In any other case, you will need to update the font either in `traitCollectionDidChange()` or by observing the `UIContentSizeCategoryDidChange` notification.
     
     - Parameters:
        - textStyle: The text style used to scale the text.
        - maxSize: Size which the text may not exceed.
     
     - Returns: A system font object corresponding to the given parameters.
     */
    public func of(textStyle: UIFont.TextStyle, maxSize: CGFloat? = nil) -> UIFont {
        if self == .preferred && maxSize == nil {
            return .preferredFont(forTextStyle: textStyle)
        }
        
        let pointSize = UIFont.preferredFont(forTextStyle: textStyle).pointSize
        
        if let maxSize = maxSize, pointSize > maxSize {
            return of(size: maxSize)
        } else {
            return of(size: pointSize)
        }
    }
    
}
