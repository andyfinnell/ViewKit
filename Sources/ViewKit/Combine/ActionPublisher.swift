import Foundation
import Combine

public struct ActionPublisher<TargetType: Targetable>: Publisher {
    public typealias Output = Void
    public typealias Failure = Never
    
    private let target: TargetType
    private let targetEvent: TargetableEvent
    
    public init(target: TargetType, targetEvent: TargetableEvent) {
        self.target = target
        self.targetEvent = targetEvent
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = Subscription(subscriber: subscriber,
                                        target: target,
                                        event: targetEvent)
        subscriber.receive(subscription: subscription)
    }
}

private extension ActionPublisher {
    final class Subscription<SubscriberType: Subscriber, TargetType: Targetable>: Combine.Subscription where SubscriberType.Input == Void {
        private var subscriber: SubscriberType?
        private weak var target: TargetType?
        private let event: TargetableEvent
        
        init(subscriber: SubscriberType, target: TargetType, event: TargetableEvent) {
            self.subscriber = subscriber
            self.target = target
            self.event = event
            
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
            _ = subscriber?.receive()
        }
    }
}
