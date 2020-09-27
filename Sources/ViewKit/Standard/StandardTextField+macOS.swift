import Foundation
#if canImport(AppKit)
import AppKit
import Combine

public final class StandardTextField: NSTextField {
    private let actionTarget = ActionTarget(primaryAction: .valueChanged)

    public enum Format {
        case standard
        case email
    }

    public init(format: Format = .standard, placeholder: String? = nil, id: String? = nil) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        setAccessibilityIdentifier(id)
        target = actionTarget
        action = #selector(ActionTarget.sendPrimaryAction)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var text: String? {
        get { stringValue }
        set { stringValue = newValue ?? "" }
    }

    public var placeholder: String? {
        get { placeholderString }
        set { placeholderString = newValue }
    }
    
    public override func textDidChange(_ notification: Notification) {
        actionTarget.sendActions(for: .valueChanged)
    }
}

extension StandardTextField: Targetable {
    public func addTarget(_ target: Any?, action: Selector, for event: TargetableEvent) {
        actionTarget.addTarget(target, action: action, for: event)
    }
    
    public func removeTarget(_ target: Any?, action: Selector?, for event: TargetableEvent) {
        actionTarget.removeTarget(target, action: action, for: event)
    }
}

public extension PublisherContainer where TargetableType: StandardTextField {
    var text: AnyPublisher<String?, Never> {
        ActionPropertyPublisher(target: targetable, targetEvent: .valueChanged, keyPath: \.text)
            .eraseToAnyPublisher()
    }
}

#endif
