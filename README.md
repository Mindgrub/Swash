# Swash

[![Version](https://img.shields.io/cocoapods/v/Swash.svg?style=flat)](http://cocoapods.org/pods/Swash)
[![License](https://img.shields.io/cocoapods/l/Swash.svg?style=flat)](http://cocoapods.org/pods/Swash)
[![Platform](https://img.shields.io/cocoapods/p/Swash.svg?style=flat)](http://cocoapods.org/pods/Swash)

Swash is a simple, safe, and expressive abstraction of `UIFont` with baked-in support for dynamic type.

## Installation

Swash is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

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
Uses `UIFontMetrics` for scaling. See our blogpost for guidance on choosing default sizes for text styles.
```swift
label.font = Papyrus.condensed.of(textStyle: .body, defaultSize: 17)
// Optional size cutoff
label.font = Papyrus.condensed.of(textStyle: .body, defaultSize: 17, maxSize: 30)
```
#### Dynamic Type (Before iOS 11)
Uses system font scaling, no default size value.
```swift
label.font = Papyrus.condensed.of(textStyle: .body)
// Optional size cutoff
label.font = Papyrus.condensed.of(textStyle: .body, maxSize: 30)
```

#### System Font
You can use the system font to support dynamic type for different weights and further unify the font syntax in your project.
```swift
label.font = SystemFont.light.of(size: 17)
label.font = SystemFont.semibold.of(textStyle: .body)
label.font = SystemFont.semiboldItalic.of(textStyle: .body, maxSize: 30)
```

#### Generate Boilerplate
Swash can attempt to log your font boilerplate for you!
```swift
Swash.logFontBoilerplate(filter: "gill sans")
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
If your custom font cannot be initialized, `assertionFailure()` is called. This will crash debug builds with the default `None` compiler optimization set. This is to help identify failed font initializations which can otherwise be hard to catch. **Release builds with higher optimization levels will NOT crash**, so you don't have to worry about your app crashing in production over a silly font.

## License

Swash is available under the MIT license. See the LICENSE file for more info.
