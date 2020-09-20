import Foundation
import Combine

public struct ActionPropertyPublisher<TargetType: Targetable, PropertyType>: Publisher {
    public typealias Output = PropertyType
    public typealias Failure = Never
    
    private let target: TargetType
    private let targetEvent: TargetableEvent
    private let keyPath: KeyPath<TargetType, PropertyType>
    
    public init(target: TargetType, targetEvent: TargetableEvent, keyPath: KeyPath<TargetType, PropertyType>) {
        self.target = target
        self.targetEvent = targetEvent
        self.keyPath = keyPath
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = Subscription(subscriber: subscriber,
                                        target: target,
                                        event: targetEvent,
                                        keyPath: keyPath)
        subscriber.receive(subscription: subscription)
    }
}

private extension ActionPropertyPublisher {
    final class Subscription<SubscriberType: Subscriber, TargetType: Targetable, PropertyType>: Combine.Subscription where SubscriberType.Input == PropertyType {
        private var subscriber: SubscriberType?
        private weak var target: TargetType?
        private let event: TargetableEvent
        private let keyPath: KeyPath<TargetType, PropertyType>

        init(subscriber: SubscriberType, target: TargetType, event: TargetableEvent, keyPath: KeyPath<TargetType, PropertyType>) {
            self.subscriber = subscriber
            self.target = target
            self.event = event
            self.keyPath = keyPath
            
            target.addTarget(self, action: #selector(onEvent(_:)), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {
            // we're a "hot" observable
        }
        
        func cancel() {
            target?.removeTarget(self, action: #selector(onEvent(_:)), for: event)
            subscriber = nil
        }
        
        @objc private func onEvent(_ sender: Any?) {
            guard let target = target else { return }
            
            _ = subscriber?.receive(target[keyPath: keyPath])
        }
    }
}
