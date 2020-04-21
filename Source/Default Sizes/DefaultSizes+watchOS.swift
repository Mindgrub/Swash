#if os(watchOS)
import WatchKit

/**
 Default text sizes taken from Apple's Human Interface Guidelines ([iOS](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/), [watchOS](https://developer.apple.com/design/human-interface-guidelines/watchos/visual-design/typography/), [tvOS](https://developer.apple.com/design/human-interface-guidelines/tvos/visual-design/typography/)). These sizes correspond to the default category used by `UIFontMetrics` for dynamic type. It varies per OS and device.
 */
internal let defaultSizes: [UIFont.TextStyle: CGFloat] = {
    if #available(watchOS 5.0, *) {
        switch (WKInterfaceDevice.current().preferredContentSizeCategory) {
        case "UICTContentSizeCategoryS":
            return [.footnote: 12,
                    .caption2: 13,
                    .caption1: 14,
                    .body: 15,
                    .headline: 15,
                    .title3: 18,
                    .title2: 26,
                    .title1: 30,
                    .largeTitle: 32]
        case "UICTContentSizeCategoryL":
            return [.footnote: 13,
                    .caption2: 14,
                    .caption1: 15,
                    .body: 16,
                    .headline: 16,
                    .title3: 19,
                    .title2: 27,
                    .title1: 34,
                    .largeTitle: 36]
        case "UICTContentSizeCategoryXL":
            return [.footnote: 14,
                    .caption2: 15,
                    .caption1: 16,
                    .body: 17,
                    .headline: 17,
                    .title3: 20,
                    .title2: 30,
                    .title1: 38,
                    .largeTitle: 40]
        default:
            return [:]
        }
    } else {
        /// No `largeTitle` before watchOS 5
        switch (WKInterfaceDevice.current().preferredContentSizeCategory) {
        case "UICTContentSizeCategoryS":
            return [.footnote: 12,
                    .caption2: 13,
                    .caption1: 14,
                    .body: 15,
                    .headline: 15,
                    .title3: 18,
                    .title2: 26,
                    .title1: 30]
        case "UICTContentSizeCategoryL":
            return [.footnote: 13,
                    .caption2: 14,
                    .caption1: 15,
                    .body: 16,
                    .headline: 16,
                    .title3: 19,
                    .title2: 27,
                    .title1: 34]
        default:
            return [:]
        }
    }
}()
#endif
