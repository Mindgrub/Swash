//
//  Fonts.swift
//  Swash
//
//  Created by Sam Francis on 2/6/18.
//  Copyright © 2018 Mindgrub. All rights reserved.
//

import Swash

enum Avenir: String, Font {
    case book = "Avenir-Book"
    case heavy = "Avenir-Heavy"
    case blackOblique = "Avenir-BlackOblique"
    case black = "Avenir-Black"
    case lightOblique = "Avenir-LightOblique"
    case bookOblique = "Avenir-BookOblique"
    case light = "Avenir-Light"
    case medium = "Avenir-Medium"
    case heavyOblique = "Avenir-HeavyOblique"
    case oblique = "Avenir-Oblique"
    case roman = "Avenir-Roman"
    case mediumOblique = "Avenir-MediumOblique"
    
    var boldTextMapping: Avenir {
        switch self {
        case .light: return .book
        case .book: return .roman
        case .roman: return .medium
        case .medium: return .heavy
        case .heavy: return .black
        case .lightOblique: return .bookOblique
        case .bookOblique: return .mediumOblique
        case .mediumOblique: return .oblique
        case .oblique: return .heavyOblique
        case .heavyOblique: return .blackOblique
        case .blackOblique, .black: return self
        }
    }
}

enum Futura: String, Font {
    case bold = "Futura-Bold"
    case mediumItalic = "Futura-MediumItalic"
    case condensedExtraBold = "Futura-CondensedExtraBold"
    case condensedMedium = "Futura-CondensedMedium"
    case medium = "Futura-Medium"
}

enum Papyrus: String, Font {
    case condensed = "Papyrus-Condensed"
    case regular = "Papyrus"
    
    var cascadeList: [CascadingFontProperties] {
        [.init(Damascus.regular)]
    }
}

enum Damascus: String, Font {
    case bold = "DamascusBold"
    case light = "DamascusLight"
    case regular = "Damascus"
    case medium = "DamascusMedium"
    case semiBold = "DamascusSemiBold"
}

enum InvalidFont: String, Font {
    case doesNotExist = "😈"
}
