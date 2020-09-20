import Foundation
import XCTest
import ViewKit

private final class FakeTarget {
    var wasCalled = false
    
    @objc func onAction(_ arg: Any?) {
        wasCalled = true
    }
}

final class ActionTargetTests: XCTestCase {
    private var subject: ActionTarget!
    
    override func setUp() {
        super.setUp()
        subject = ActionTarget(primaryAction: .primaryActionTriggered)
    }
    
    func testAddTarget() {
        let target1 = FakeTarget()
        
        subject.addTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryActionTriggered)
        
        XCTAssertFalse(target1.wasCalled)
        
        subject.sendActions(for: .primaryActionTriggered)
        
        XCTAssertTrue(target1.wasCalled)
    }
    
    func testRemoveTargetByExactMatch() {
        let target1 = FakeTarget()
        
        subject.addTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryActionTriggered)
        subject.removeTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryActionTriggered)
        
        subject.sendActions(for: .primaryActionTriggered)
        
        XCTAssertFalse(target1.wasCalled)
    }
    
    func testRemoveTargetByEventOnly() {
        let target1 = FakeTarget()
        
        subject.addTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryActionTriggered)
        subject.removeTarget(nil, action: nil, for: .primaryActionTriggered)
        
        subject.sendActions(for: .primaryActionTriggered)
        
        XCTAssertFalse(target1.wasCalled)
    }

    func testMutipleTargets() {
        let target1 = FakeTarget()
        let target2 = FakeTarget()

        subject.addTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryActionTriggered)
        subject.addTarget(target2, action: #selector(FakeTarget.onAction(_:)), for: .primaryActionTriggered)

        
        subject.sendActions(for: .primaryActionTriggered)
        
        XCTAssertTrue(target1.wasCalled)
        XCTAssertTrue(target2.wasCalled)
    }
}
