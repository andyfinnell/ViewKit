import Foundation

#if canImport(UIKit)
import UIKit

public typealias TargetableEvent = UIControl.Event

#endif

#if canImport(AppKit)
import AppKit

public struct TargetableEvent: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let primaryActionTriggered = TargetableEvent(rawValue: 1 << 0)
    public static let valueChanged = TargetableEvent(rawValue: 1 << 1)
}


#endif

public protocol Targetable: AnyObject {
    func addTarget(_ target: Any?, action: Selector, for event: TargetableEvent)
    func removeTarget(_ target: Any?, action: Selector?, for event: TargetableEvent)
}
