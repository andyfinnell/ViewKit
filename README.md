# ViewKit
![Tests](https://github.com/andyfinnell/ViewKit/workflows/Tests/badge.svg) [![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

ViewKit is my personal Swift API for building programmatic views using UIKit, AppKit, and Autolayout. The goal of ViewKit is to remove the need to copy-pasta this code from project to project, or have to re-invent the wheel for each new app. 

ViewKit supports iOS, macOS, and tvOS.

## Requirements

- Swift 5.2 or greater
- iOS/tvOS 13 or greater OR macOS 10.15 or greater

## Installation

Currently, ViewKit is only available as a Swift Package.

### ...using a Package.swift file

Open the Package.swift file and edit it:

1. Add ViewKit repo to the `dependencies` array.
1. Add ViewKit as a dependency of the target that will use it

```Swift
// swift-tools-version:5.2

import PackageDescription

let package = Package(
  // ...snip...
  dependencies: [
    .package(url: "https://github.com/andyfinnell/ViewKit.git", from: "0.0.1")
  ],
  targets: [
    .target(name: "MyTarget", dependencies: ["ViewKit"])
  ]
)
```

Then build to pull down the dependencies:

```Bash
$ swift build
```

### ...using Xcode

Use the Swift Packages tab on the project to add ViewKit:

1. Open the Xcode workspace or project that you want to add ViewKit to
1. In the file browser, select the project to show the list of projects/targets on the right
1. In the list of projects/targets on the right, select the project
1. Select the "Swift Packages" tab
1. Click on the "+" button to add a package
1. In the "Choose Package Repository" sheet, search for  "https://github.com/andyfinnell/ViewKit.git"
1. Click "Next"
1. Choose the version rule you want
1. Click "Next"
1. Choose the target you want to add ViewKit to
1. Click "Finish"

## Usage 

### ViewHierarchy

`ViewHierarchy` is a type used to declare a a tree of views. It's primarily leveraged by `StandardView`to construct a view hierarchy on `init`. The goal of this type is to allow the view hierarchy to visually look like a tree in Swift code.

`ViewHierarchy` is an enum with three values:

```Swift
case hierarchy(NativeView, subviews: [ViewHierarchy])
case superview(NativeView, subviews: [NativeView])
case views([NativeView])
```

The `hierarchy` is the canonical value: it can be used by itself to declare a full view hierarchy. For example:

```Swift
.hierarchy(contentView, subviews: [
    // titleLabel, descriptionLabel, submitButton are all siblings
    .hierarchy(titleLabel, subviews: []),
    .hierarchy(descriptionLabel, subviews: []),
    .hierarchy(submitButton, subviews: [])
])
```

`contentView` is the superview for `titleLabel`, `descriptionLabel`, and `submitButton`.

The `superview` and `views` enum values are syntactic sugar to reduce some of the noise when declaring view hierarchies. Here's the previous example using `superview`:

```Swift
.superview(contentView, subviews: [
    titleLabel,
    descriptionLabel,
    submitButton
])
```

The `views` enum value is used to represent leave views. The same view hierarchy but using `.views`:

```Swift
.hierarchy(contentView, subviews: [
    .views([
        titleLabel,
        descriptionLabel,
        submitButton
    ])
])
```

`ViewHierarchy`'s `install(on:)` must be called to parent all the views properly using `addSubview(_:)`. `StandardView` will do the automatically for its `var hierarchy: ViewHierarchy` property.

### Layout

`Layout` is a type used to declare a group of Autolayout constraints on a view. It's primarily leveraged by `StandardView` to apply layout constraints on its view hierarchy. The goal of this type to reduce the boilerplate needed to build layouts.

TBD

### Standard controls

ViewKit defines some subclasses of standard UIKit and AppKit controls. It attempts to make it easier to construct the controls in code, to make the APIs between UIKit and AppKit more consistent, and provide Combine Publishers for any actions.

The standard controls are:

- `StandardActivityIndicator`
- `StandardButton`
- `StandardContainerView` - defines a `backgroundColor` in AppKit
- `StandardLabel`
- `StandardStackView`
- `StandardTextField`
- `StandardView` - defines a common base class for programmatic views. Defines `hierarchy: ViewHierarchy` and `layout: [Layout]` properties for convenience.

### Combine Publishers

ViewKit defines some helper types to make it easier to add Combine Publishers to AppKit/UIKit controls for user actions.

First, it defines `ActionPublisher` which creates a Publisher for any control event. For example:

```Swift
public extension PublisherContainer where TargetableType: StandardButton {
    var press: AnyPublisher<Void, Never> {
        ActionPublisher(target: targetable, targetEvent: .touchUpInside).eraseToAnyPublisher()
    }
}
```

Here, it creates a `press` Publisher that fires any time the `StandardButton` instance first a `.touchUpInsideEvent`.

ViewKit also defines `ActionPropertyPublisher` which works the same way, except it also reads a property off the control and sends it as a value. For example:

```Swift
public extension PublisherContainer where TargetableType: StandardTextField {
    var text: AnyPublisher<String?, Never> {
        ActionPropertyPublisher(target: targetable, targetEvent: .valueChanged, keyPath: \.text)
            .eraseToAnyPublisher()
    }
}
```
 
 This creates a `text` Publisher that sends a value any time the `StandardTextField` emits a `.valueChanged` control event. It pulls the value off the key path provided.
 
Both of the examples demonstrate how to add a Publisher to the `publisher` namespace on a control type. Simply add a conditional `extension` to `PublisherContainer` where `TargetableType` conforms to the type you want to add a Publisher property to.

The `text` Publisher would be used like:

```Swift
let textField = StandardTextField()
textField.publisher.text.sink { newText in
    // do what you want with the new text value
}.store(in: &cancellables)
```

Finally, ViewKit provides a helper type called `ActionTarget` that can contain multiple target/action pairs. This is helpful since most AppKit controls -- and a couple of UIKit controls -- only support one target/action pair, but `ActionPublisher` and `ActionPropertyPublisher` need multiple pair support. i.e. they require the control to implement the `Targetable` protocol. The `ActionTarget` makes implementing that protocol easier.

### Styling

ViewKit provides some basic styling capabilities. To begin with, it adds `NSFont.TextStyle` and `NSFont.preferredFont(forTextStyle:)` to match the corresponding types and method on `UIFont`. This allows font styles to be specified the same way across platforms.

It defines `StyleSheet` as a singleton object that contains the styles for the entire app. At startup, the app can `define` the styles it wants for each control type. Then when a `Stylable` control is created, it will query the `StyleSheet` singleton for its style.

Each control can opt into the styling system by implementing the `Stylable` protocol. For example:

```Swift
final class Widget: UIView, Stylable {
    struct Style {
        let textColor: UIColor
    }
    static let defaultStyle = Style(textColor: .purple)
}
```

The `Stylable` protocol requires the definition of a `static var` called `defaultStyle`. This is the style that will be used when an override isn't defined by the app. The style type can be anything the control needs.

The control uses the style by looking it up on the `StyleSheet`:

```Swift
final class Widget: UIView, Stylable {
    // ...snip...
    
    init() {
        let style = StyleSheet.shared.lookup(Self.self)
        label.textColor = style.textColor
    }
}
```

At startup, the app can override the default styles. For example:

```Swift
func styleApp() {
    StyleSheet.shared.define(Widget.Style(textColor: .green), for: Widget.self)
}
```
