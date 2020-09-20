import Foundation
import Combine
import XCTest
import ViewKit

final class ActionPublisherTests: XCTestCase {
    func testSubscribe() {
        let target = ActionTarget(primaryAction: .primaryAction)
        let subject = ActionPublisher(target: target, targetEvent: .primaryAction)
        var cancellables = Set<AnyCancellable>()
        let finishExpectation = expectation(description: "finish")
        var isComplete = false
        
        subject.sink {
            isComplete = true
            finishExpectation.fulfill()
        }.store(in: &cancellables)
        
        target.sendPrimaryAction()
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssert(isComplete)
    }
}
