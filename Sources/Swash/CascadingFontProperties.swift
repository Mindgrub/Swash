
public struct CascadingFontProperties {
    public let fontName: String
    public let boldFontName: String?

    public init<F: Font>(_ font: F) {
        self.fontName = font.rawValue
        self.boldFontName = font.boldTextMapping.rawValue
    }
}
