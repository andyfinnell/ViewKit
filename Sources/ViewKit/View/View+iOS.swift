#if canImport(UIKit)
import UIKit

extension UIView: Viewable {
    @objc public func install(view: NativeView) {
        addSubview(view)
    }
}

extension UIStackView {
    public override func install(view: NativeView) {
        addArrangedSubview(view)
    }
}

public extension UIView {
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
