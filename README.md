# Swash

[![Version](https://img.shields.io/cocoapods/v/Swash.svg?style=flat)](#installation)
![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg)
![Platforms](https://img.shields.io/cocoapods/p/Swash.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Swash.svg?style=flat)](http://doge.mit-license.org)

Swash is a simple, safe, and expressive abstraction of `UIFont` with baked-in support for dynamic type.

## Usage
To define a custom font, just create a `String` enum that conforms to the `Font` protocol.
```swift
enum Papyrus: String, Font {
    case regular = "Papyrus"
    case condensed = "Papyrus-Condensed"
}
```

That's all you need to start using your font in your project!

### Static Sizes
```swift
label.font = Papyrus.regular.of(size: 17)
```

### Dynamic Type (iOS 11+)
Uses [`UIFontMetrics`](https://developer.apple.com/documentation/uikit/uifontmetrics) for scaling. Setting [`adjustsFontForContentSizeCategory`](https://developer.apple.com/documentation/uikit/uicontentsizecategoryadjusting/1771731-adjustsfontforcontentsizecategor) to `true` tells the label to automatically update the font when the user changes their content size preference. See our [blog post](https://blog.mindgrub.com/custom-fonts-in-ios-made-simple-yet-powerful) for guidance on choosing default sizes for text styles, or just use Swash's provided defaults pulled from Apple's Human Interface Guidelines for [iOS](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/), [watchOS](https://developer.apple.com/design/human-interface-guidelines/watchos/visual-design/typography/), and [tvOS](https://developer.apple.com/design/human-interface-guidelines/tvos/visual-design/typography/).
```swift
label1.adjustsFontForContentSizeCategory = true
label2.adjustsFontForContentSizeCategory = true

label1.font = Papyrus.condensed.of(textStyle: .headline)
// Optional size cutoff and default size.
label2.font = GillSans.bold.of(textStyle: .title1, defaultSize: 28, maxSize: 38)
```
![Dynamic Type Demo](https://raw.githubusercontent.com/Mindgrub/Swash/master/Assets/dynamic_type_demo.gif)

### Dynamic Type (Before iOS 11)
Uses system font scaling, no default size value. [`adjustsFontForContentSizeCategory`](https://developer.apple.com/documentation/uikit/uicontentsizecategoryadjusting/1771731-adjustsfontforcontentsizecategor) requires the use of [`UIFontMetrics`](https://developer.apple.com/documentation/uikit/uifontmetrics), so it is of no use for custom fonts before iOS 11. You'll have to update the fonts manually, either in [`traitCollectionDidChange(_:)`](https://developer.apple.com/documentation/uikit/uitraitenvironment/1623516-traitcollectiondidchange) or by observing the [`UIContentSizeCategoryDidChange`](https://developer.apple.com/documentation/foundation/nsnotification.name/1622948-uicontentsizecategorydidchange) notification.
```swift
label.font = Papyrus.condensed.of(style: .headline)
// Optional size cutoff
label.font = GillSans.bold.of(style: .title1, maxSize: 30)
```

### System Font
You can use `SystemFont` to support dynamic type for different weights and further unify the font syntax in your project.
```swift
label1.font = SystemFont.light.of(size: 17)
label2.adjustsFontForContentSizeCategory = true
label2.font = SystemFont.preferred.of(textStyle: .body)
label3.font = SystemFont.semiboldItalic.of(textStyle: .body, maxSize: 30)
```
**Important note:** [`adjustsFontForContentSizeCategory`](https://developer.apple.com/documentation/uikit/uicontentsizecategoryadjusting/1771731-adjustsfontforcontentsizecategor) only works with `SystemFont` for the `preferred` weight with a nil `maxSize` value. In any other case, you will need to update the font either in [`traitCollectionDidChange(_:)`](https://developer.apple.com/documentation/uikit/uitraitenvironment/1623516-traitcollectiondidchange) or by observing the [`UIContentSizeCategoryDidChange`](https://developer.apple.com/documentation/foundation/nsnotification.name/1622948-uicontentsizecategorydidchange) notification. This is because the `preferred` weight directly returns the result of [`UIFont.preferredFont(forTextStyle:)`](https://developer.apple.com/documentation/uikit/uifont/1619030-preferredfont).

### Bold Text Device Setting
You can implement the `boldTextMapping` property on any `Font` in order to support the "Bold Text" device setting on iOS and tvOS.
```
var boldTextMapping: MyFont {
    switch self {
    case .regular: return .bold
    case .bold: return .black
    case .black: return self
    }
}
```
Now every regular `MyFont` instance will become bold if the user has "Bold Text" turned on in their device settings.

If you'd like, you can observe `UIAccessibility.boldTextStatusDidChangeNotification` via `NotificationCenter` and set your fonts when that updates.

### Font Cascading
You can implement the static `cascadeList` property on any `Font` in order to support font cascading. In the event that your font does not support a character that is used in a label, this list will provide fallback fonts to use.
```
enum Papyrus: String, Font {
    case condensed = "Papyrus-Condensed"
    case regular = "Papyrus"
    
    var cascadeList: [CascadingFontProperties] {
        [.init(Damascus.regular)]
    }
}
```
Papyrus does not support Arabic characters. So, here we've provided Damascus as a fallback. If no fallback is provided, the system font will be used for unsupported characters.

### Generate Boilerplate
Swash can attempt to log your font boilerplate for you!
```swift
Swash.logBoilerplate(forFontsWithFamilyNamesContaining: "gill")
```
Output:
```
enum GillSans: String, Font {
    case GillSans-Italic = "GillSans-Italic"
    case GillSans-SemiBold = "GillSans-SemiBold"
    case GillSans-UltraBold = "GillSans-UltraBold"
    case GillSans-Light = "GillSans-Light"
    case GillSans-Bold = "GillSans-Bold"
    case GillSans = "GillSans"
    case GillSans-SemiBoldItalic = "GillSans-SemiBoldItalic"
    case GillSans-BoldItalic = "GillSans-BoldItalic"
    case GillSans-LightItalic = "GillSans-LightItalic"
}
```
Just copy-paste the output into your project. You'll probably still need to doctor the case names a bit.

### Debug Crashing
If your custom font fails to initialize, [`assertionFailure(_:file:line:)`](https://developer.apple.com/documentation/swift/1539616-assertionfailure) is called. This will crash debug builds with the default `-Onone` compiler optimization set. This is to help identify failed font initializations which can otherwise be hard to catch. **Release builds with higher optimization levels will NOT crash**, so you don't have to worry about your app crashing in production over a silly font.

## Installation

### CocoaPods

```ruby
pod 'Swash'
```

### Carthage

```
github "Mindgrub/Swash"
```
Make sure to specify your platform when you update (e.g. `carthage update --platform iOS`). Otherwise all 3 frameworks (iOS, tvOS, and watchOS) will be added.

## License

Swash is available under the MIT license. See the LICENSE file for more info.
