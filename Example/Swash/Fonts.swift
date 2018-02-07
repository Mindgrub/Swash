//
//  Fonts.swift
//  Swash
//
//  Created by Sam Francis on 2/6/18.
//  Copyright (c) 2018 Mindgrub. All rights reserved.
//

import Swash

enum Papyrus: String, Font {
    case regular = "Papyrus"
    case condensed = "Papyrus-Condensed"
}

enum GillSans: String, Font {
    case italic = "GillSans-Italic"
    case semiBold = "GillSans-SemiBold"
    case ultraBold = "GillSans-UltraBold"
    case light = "GillSans-Light"
    case bold = "GillSans-Bold"
    case regular = "GillSans"
    case semiBoldItalic = "GillSans-SemiBoldItalic"
    case boldItalic = "GillSans-BoldItalic"
    case lightItalic = "GillSans-LightItalic"
}

enum BogusFont: String, Font {
    case crashDebugBuilds = "😈"
}
