import Foundation
#if canImport(AppKit)
import AppKit
import Combine

public final class StandardButton: NSButton {
    private let activityIndicator = StandardActivityIndicator()
    private let actionTarget = ActionTarget(primaryAction: .primaryActionTriggered)
    
    public init(text: String?, isDefault: Bool = false, id: String? = nil) {
        super.init(frame: .zero)
        self.title = text ?? ""
        setButtonType(.momentaryPushIn)
        bezelStyle = .rounded
        translatesAutoresizingMaskIntoConstraints = false
        setAccessibilityIdentifier(id)
        addSubview(activityIndicator)
        if isDefault {
            keyEquivalent = "\r"
        }
        NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        target = actionTarget
        action = #selector(ActionTarget.sendPrimaryAction)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: the animating of this currently looks pants
    public func startAnimating() {
        activityIndicator.startAnimating()
        isEnabled = false
    }
    
    public func stopAnimating() {
        activityIndicator.stopAnimating()
        isEnabled = true
    }
    
    public var isAnimating: Bool {
        get { activityIndicator.isAnimating }
        set {
            if newValue {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
    }
}

extension StandardButton: Targetable {
    public func addTarget(_ target: Any?, action: Selector, for event: TargetableEvent) {
        actionTarget.addTarget(target, action: action, for: event)
    }
    
    public func removeTarget(_ target: Any?, action: Selector?, for event: TargetableEvent) {
        actionTarget.removeTarget(target, action: action, for: event)
    }
}

public extension PublisherContainer where TargetableType: StandardButton {
    var press: AnyPublisher<Void, Never> {
        ActionPublisher(target: targetable, targetEvent: .primaryActionTriggered).eraseToAnyPublisher()
    }
}

#endif
