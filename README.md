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

TBD

### Layout

`Layout` is a type used to declare a group of Autolayout constraints on a view. It's primarily leveraged by `StandardView` to apply layout constraints on its view hierarchy. The goal of this type to reduce the boilerplate needed to build layouts.

TBD
