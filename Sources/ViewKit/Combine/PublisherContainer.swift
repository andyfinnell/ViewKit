import Foundation

public struct PublisherContainer<TargetableType> {
    public let targetable: TargetableType
    
    public init(_ targetable: TargetableType) {
        self.targetable = targetable
    }
}

public protocol HasPublishers {
    associatedtype TargetableType
    
    var publisher: PublisherContainer<TargetableType> { get }
}

public extension HasPublishers {
    var publisher: PublisherContainer<Self> { PublisherContainer(self) }
}

extension NSObject: HasPublishers {}
