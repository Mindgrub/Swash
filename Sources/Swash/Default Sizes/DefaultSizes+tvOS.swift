#if os(tvOS)
import UIKit

/**
 Default text sizes taken from Apple's Human Interface Guidelines ([iOS](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/), [watchOS](https://developer.apple.com/design/human-interface-guidelines/watchos/visual-design/typography/), [tvOS](https://developer.apple.com/design/human-interface-guidelines/tvos/visual-design/typography/)). These sizes correspond to the default category used by `UIFontMetrics` for dynamic type. It varies per OS and device.
 */
@available(tvOS 11.0, *)
internal let defaultSizes: [UIFont.TextStyle: CGFloat] =
    [.caption2: 23,
     .caption1: 25,
     .footnote: 29,
     .subheadline: 29,
     .body: 29,
     .callout: 31,
     .headline: 38,
     .title3: 48,
     .title2: 57,
     .title1: 76]
#endif
