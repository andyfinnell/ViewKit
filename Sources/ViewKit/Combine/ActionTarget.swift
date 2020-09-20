import Foundation

public final class ActionTarget: Targetable {
    private var records = [Record]()
    private let primaryAction: TargetableEvent
    
    public init(primaryAction: TargetableEvent) {
        self.primaryAction = primaryAction
    }
    
    @objc public func sendPrimaryAction() {
        sendActions(for: primaryAction)
    }
    
    public func sendActions(for event: TargetableEvent) {
        for record in records {
            record.sendActions(for: event)
        }
    }
    
    public func addTarget(_ target: Any?, action: Selector, for event: TargetableEvent) {
        guard let targetObject = target as AnyObject? else { return }
        records.append(Record(target: targetObject, action: action, events: event))
    }
    
    public func removeTarget(_ target: Any?, action: Selector?, for event: TargetableEvent) {
        let targetObject = target as AnyObject?
        records = records.filter { !$0.shouldBeRemoved(target: targetObject, action: action, events: event) }
    }
}

private extension ActionTarget {
    struct Record {
        private weak var target: AnyObject?
        private let action: Selector
        private let events: TargetableEvent
        
        init(target: AnyObject, action: Selector, events: TargetableEvent) {
            self.target = target
            self.action = action
            self.events = events
        }
        
        func sendActions(for event: TargetableEvent) {
            guard self.events.contains(event) else { return }
            // We don't handle targeting the responder chain
            _ = target?.perform(action, with: nil)
        }

        func shouldBeRemoved(target: AnyObject?, action: Selector?, events: TargetableEvent) -> Bool {
            let matchesTarget = target == nil || self.target === target
            let matchesAction = action == nil || self.action == action
            let matchesEvents = self.events == events
            return matchesTarget && matchesAction && matchesEvents
        }
    }
}
