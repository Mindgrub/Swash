//
//  SystemFont.swift
//  Swash
//
//  Created by Sam Francis on 1/26/18.
//

import UIKit

// System font implementation, with extra methods to support dynamic type
@available(iOS 8.2, *)
public enum SystemFont {
    case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black, italic, semiboldItalic, condensed
    
    private enum Style {
        case weight(UIFont.Weight)
        case traits(UIFontDescriptorSymbolicTraits)
    }
    
    private var style: Style {
        switch self {
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
        switch style {
        case .weight(let weight):
            return .systemFont(ofSize: size, weight: weight)
        case .traits(let traits):
            if let descriptor = UIFont.systemFont(ofSize: size).fontDescriptor.withSymbolicTraits(traits) {
                return UIFont(descriptor: descriptor, size: size)
            }
        }
        
        return .systemFont(ofSize: size)
    }
    
    public func of(textStyle: UIFontTextStyle) -> UIFont {
        return of(size: UIFont.preferredFont(forTextStyle: textStyle).pointSize)
    }
    
    public func of(textStyle: UIFontTextStyle, maxSize: CGFloat) -> UIFont {
        let font = of(textStyle: textStyle)
        if font.pointSize <= maxSize {
            return font
        } else {
            return of(size: maxSize)
        }
    }
    
}
