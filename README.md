# Swash

[![Version](https://img.shields.io/cocoapods/v/Swash.svg?style=flat)](http://cocoapods.org/pods/Swash)
[![License](https://img.shields.io/cocoapods/l/Swash.svg?style=flat)](http://cocoapods.org/pods/Swash)
[![Platform](https://img.shields.io/cocoapods/p/Swash.svg?style=flat)](http://cocoapods.org/pods/Swash)

Swash is a simple, safe, and expressive abstraction of `UIFont` with baked-in support for dynamic type.

## Installation

Swash is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Swash'
```

## Usage
To define a custom font, just create a `String` enum that conforms to the `Font` protocol.
```swift
enum Papyrus: String, Font {
    case regular = "Papyrus"
    case condensed = "Papyrus-Condensed"
}
```

That's all you need to start using your font in your project!

#### Static Sizes
```swift
label.font = Papyrus.regular.of(size: 17)
```

#### Dynamic Type (iOS 11+)
Uses [`UIFontMetrics`](https://developer.apple.com/documentation/uikit/uifontmetrics) for scaling. Setting [`adjustsFontForContentSizeCategory`](https://developer.apple.com/documentation/uikit/uicontentsizecategoryadjusting/1771731-adjustsfontforcontentsizecategor) to `true` tells the label to automatically update the font when the user changes their content size preference. See our [blogpost](https://mindgrub.com/blog) for guidance on choosing default sizes for text styles.
```swift
label1.adjustsFontForContentSizeCategory = true
label2.adjustsFontForContentSizeCategory = true

label.font = Papyrus.condensed.of(textStyle: .body, defaultSize: 17)
// Optional size cutoff
label.font = Papyrus.condensed.of(textStyle: .body, defaultSize: 17, maxSize: 30)
```
#### Dynamic Type (Before iOS 11)
Uses system font scaling, no default size value. [`adjustsFontForContentSizeCategory`](https://developer.apple.com/documentation/uikit/uicontentsizecategoryadjusting/1771731-adjustsfontforcontentsizecategor) requires the use of [`UIFontMetrics`](https://developer.apple.com/documentation/uikit/uifontmetrics), so it is of no use for custom fonts before iOS 11. You'll have to update the fonts manually, either in [`traitCollectionDidChange(_:)`](https://developer.apple.com/documentation/uikit/uitraitenvironment/1623516-traitcollectiondidchange) or by observing the [`UIContentSizeCategoryDidChange`](https://developer.apple.com/documentation/foundation/nsnotification.name/1622948-uicontentsizecategorydidchange) notification.
```swift
label.font = Papyrus.condensed.of(textStyle: .body)
// Optional size cutoff
label.font = Papyrus.condensed.of(textStyle: .body, maxSize: 30)
```

#### System Font
You can use `SystemFont` to support dynamic type for different weights and further unify the font syntax in your project.
```swift
label1.font = SystemFont.light.of(size: 17)
label2.adjustsFontForContentSizeCategory = true
label2.font = SystemFont.preferred.of(textStyle: .body)
label3.font = SystemFont.semiboldItalic.of(textStyle: .body, maxSize: 30)
```
**Important note:** [`adjustsFontForContentSizeCategory`](https://developer.apple.com/documentation/uikit/uicontentsizecategoryadjusting/1771731-adjustsfontforcontentsizecategor) only works for `SystemFont` for the `preferred` weight with a nil `maxSize` value. In any other case, you will need to update the font either in [`traitCollectionDidChange(_:)`](https://developer.apple.com/documentation/uikit/uitraitenvironment/1623516-traitcollectiondidchange) or by observing the [`UIContentSizeCategoryDidChange`](https://developer.apple.com/documentation/foundation/nsnotification.name/1622948-uicontentsizecategorydidchange) notification. This is because the `preferred` weight directly returns the result of [`UIFont.preferredFont(forTextStyle:)`](https://developer.apple.com/documentation/uikit/uifont/1619030-preferredfont).

#### Generate Boilerplate
Swash can attempt to log your font boilerplate for you!
```swift
Swash.logFontBoilerplate(filter: "gill")
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

#### Debug Crashing
If your custom font fails to initialize, [`assertionFailure(_:file:line:)`](https://developer.apple.com/documentation/swift/1539616-assertionfailure) is called. This will crash debug builds with the default `-Onone` compiler optimization set. This is to help identify failed font initializations which can otherwise be hard to catch. **Release builds with higher optimization levels will NOT crash**, so you don't have to worry about your app crashing in production over a silly font.

## License

Swash is available under the MIT license. See the LICENSE file for more info.
