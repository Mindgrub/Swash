//
//  SystemFont.swift
//  Swash
//
//  Created by Sam Francis on 1/26/18.
//

import UIKit

// System font implementation
public enum SystemFont {
    case preferred, ultraLight, thin, light, regular, medium, semibold, bold, heavy, black, italic, semiboldItalic, condensed
    
    private enum Style {
        case weight(UIFont.Weight)
        case traits(UIFontDescriptorSymbolicTraits)
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
            
        case .condensed: return .traits([.traitCondensed])
        case .semiboldItalic: return .traits([.traitItalic, .traitBold])
        case .italic: return .traits([.traitItalic])
        }
    }
    
    public func of(size: CGFloat) -> UIFont {
        guard let style = style else {
            return .systemFont(ofSize: size)
        }
        
        switch style {
        case .weight(let weight):
            return .systemFont(ofSize: size, weight: weight)
        case .traits(let traits):
            if let descriptor = UIFont.systemFont(ofSize: size).fontDescriptor.withSymbolicTraits(traits) {
                return UIFont(descriptor: descriptor, size: size)
            } else {
                return .systemFont(ofSize: size)
            }
        }
    }
    
    /// NOTE: The `adjustsFontForContentSizeCategory` property on `UILabel`, `UITextView`, etc. only works
    /// for the `preferred` weight with a nil `maxSize` value. In any other case, you will need to update the font
    /// either in `traitCollectionDidChange()` or by observing the `UIContentSizeCategoryDidChange` notification.
    public func of(textStyle: UIFontTextStyle, maxSize: CGFloat? = nil) -> UIFont {
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
