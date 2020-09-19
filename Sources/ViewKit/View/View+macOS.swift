
#if canImport(AppKit)
import Foundation
import AppKit

extension NSView: Viewable {
    public var accessibilityIdentifier: String? {
        get {
            return accessibilityIdentifier()
        }
        set {
            setAccessibilityIdentifier(newValue)
        }
    }
    
    @objc public func install(view: NativeView) {
        addSubview(view)
    }
}

extension NSStackView {
    public override func install(view: NativeView) {
        addArrangedSubview(view)
    }
}

public extension NSView {
    var isVisible: Bool {
        get {
            return !isHidden
        }
        set {
            isHidden = !newValue
        }
    }
}

#endif
