import Foundation

#if canImport(AppKit)
import AppKit

public typealias NativeView = NSView
public typealias NativeViewController = NSViewController

#elseif canImport(UIKit)
import UIKit

public typealias NativeView = UIView
public typealias NativeViewController = UIViewController
#endif
