import Foundation

public protocol NativeViewable {
    var asView: NativeView { get }
}

extension NativeView: NativeViewable {
    public var asView: NativeView { self }
}

extension NativeViewController: NativeViewable {
    public var asView: NativeView { view }
}
