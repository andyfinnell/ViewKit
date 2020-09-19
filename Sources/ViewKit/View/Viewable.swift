import Foundation

public protocol Viewable: AnyObject {
    var subviews: [NativeView] { get }
    var accessibilityIdentifier: String? { get }
    
    func install(view: NativeView)
}
