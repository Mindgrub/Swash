#if os(iOS)
import UIKit

/**
 Default text sizes taken from Apple's Human Interface Guidelines ([iOS](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/), [watchOS](https://developer.apple.com/design/human-interface-guidelines/watchos/visual-design/typography/), [tvOS](https://developer.apple.com/design/human-interface-guidelines/tvos/visual-design/typography/)). These sizes correspond to the default category used by `UIFontMetrics` for dynamic type. It varies per OS and device.
 */
@available(iOS 11.0, *)
internal let defaultSizes: [UIFont.TextStyle: CGFloat] =
    [.caption2: 11,
     .caption1: 12,
     .footnote: 13,
     .subheadline: 15,
     .callout: 16,
     .body: 17,
     .headline: 17,
     .title3: 20,
     .title2: 22,
     .title1: 28,
     .largeTitle: 34]
#endif
