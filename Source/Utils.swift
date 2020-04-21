import UIKit

/// A namespace for Swash utility methods.
public enum Swash {
    /**
     Logs an attempt at generating custom font boilerplate.
     
     - Parameter filter: Used to narrow the log to your desired fonts. Case is ignored. Defaults to empty string.
     */
    public static func logBoilerplate(forFontsWithFamilyNamesContaining filter: String = "") {
        let trimmedFilter = filter.trimmingCharacters(in: .whitespaces).lowercased()
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
