import Foundation

public protocol ViewControllerable: AnyObject {
    var asViewController: NativeViewController { get }
}

#if canImport(AppKit)
import AppKit

extension NSViewController: ViewControllerable {
    public var asViewController: NativeViewController {
        return self
    }
}
#endif

#if canImport(UIKit)
import UIKit

extension UIViewController: ViewControllerable {
    public var asViewController: NativeViewController {
        return self
    }
}
#endif

