import Foundation

public protocol Stylable {
    associatedtype StyleType
    
    static var defaultStyle: StyleType { get }
    static var styleId: StyleId { get }
}

public extension Stylable {
    static var styleId: StyleId { StyleId(String(describing: self)) }
}
