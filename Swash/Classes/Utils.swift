//
//  Utils.swift
//  Swash
//
//  Created by Sam Francis on 1/29/18.
//

import UIKit

public enum FontManager {
    
    public enum LogLevel {
        case none, debug
    }
    
    /// Set the log level to `debug` to log when custom
    /// fonts are not loaded properly. `none` is the default,
    /// and is recommended for release builds.
    public static var logLevel: LogLevel = .none
    
    /// Call this function to log an attempt at generating
    /// custom font boilerplate.
    ///
    /// - Parameter filter: Used to narrow the log to your desired fonts.
    public static func logFontBoilerplate(filter: String = "") {
        let trimmedFilter = filter.trimmingCharacters(in: CharacterSet.whitespaces).lowercased()
        UIFont.familyNames
            .filter { $0.lowercased().contains(trimmedFilter) || trimmedFilter == "" }
            .forEach { familyName in
                var str = "\nenum \(familyName.replacingOccurrences(of: " ", with: "")): String, Font {\n"
                str += UIFont.fontNames(forFamilyName: familyName)
                    .map { "\tcase \($0) = \"\($0)\"" }
                    .joined(separator: "\n")
                
                str += "\n}"
                print(str)
        }
    }
}

func debugLog(_ message: String) {
    if FontManager.logLevel == .debug {
        print(message)
    }
}
