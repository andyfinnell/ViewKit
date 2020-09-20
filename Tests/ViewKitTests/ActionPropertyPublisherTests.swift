import Foundation
import Combine
import XCTest
import ViewKit

private final class FakePropertyTarget: Targetable {
    private let actionTarget = ActionTarget(primaryAction: .primaryActionTriggered)
    
    var value = 42
    
    init() {
        
    }
    
    func sendPrimaryAction() {
        actionTarget.sendPrimaryAction()
    }
    
    func addTarget(_ target: Any?, action: Selector, for event: TargetableEvent) {
        actionTarget.addTarget(target, action: action, for: event)
    }
    
    func removeTarget(_ target: Any?, action: Selector?, for event: TargetableEvent) {
        actionTarget.removeTarget(target, action: action, for: event)
    }
}

final class ActionPropertyPublisherTests: XCTestCase {
    func testSubscribe() {
        let target = FakePropertyTarget()
        let subject = ActionPropertyPublisher(target: target, targetEvent: .primaryActionTriggered, keyPath: \.value)
        var cancellables = Set<AnyCancellable>()
        let finishExpectation = expectation(description: "finish")
        var isComplete = false
        var finalValue: Int?
        
        subject.sink { value in
            finalValue = value
            isComplete = true
            finishExpectation.fulfill()
        }.store(in: &cancellables)
        
        target.sendPrimaryAction()
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssert(isComplete)
        XCTAssertEqual(finalValue, 42)
    }
}
