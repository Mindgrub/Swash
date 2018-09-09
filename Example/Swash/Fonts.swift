//
//  Fonts.swift
//  Swash
//
//  Created by Sam Francis on 2/6/18.
//  Copyright (c) 2018 Mindgrub. All rights reserved.
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
}

enum Futura: String, Font {
    case bold = "Futura-Bold"
    case mediumItalic = "Futura-MediumItalic"
    case condensedExtraBold = "Futura-CondensedExtraBold"
    case condensedMedium = "Futura-CondensedMedium"
    case medium = "Futura-Medium"
}

enum InvalidFont: String, Font {
    case doesNotExist = "😈"
}
