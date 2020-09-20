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
        subject = ActionTarget(primaryAction: .primaryAction)
    }
    
    func testAddTarget() {
        let target1 = FakeTarget()
        
        subject.addTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryAction)
        
        XCTAssertFalse(target1.wasCalled)
        
        subject.sendActions(for: .primaryAction)
        
        XCTAssertTrue(target1.wasCalled)
    }
    
    func testRemoveTargetByExactMatch() {
        let target1 = FakeTarget()
        
        subject.addTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryAction)
        subject.removeTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryAction)
        
        subject.sendActions(for: .primaryAction)
        
        XCTAssertFalse(target1.wasCalled)
    }
    
    func testRemoveTargetByEventOnly() {
        let target1 = FakeTarget()
        
        subject.addTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryAction)
        subject.removeTarget(nil, action: nil, for: .primaryAction)
        
        subject.sendActions(for: .primaryAction)
        
        XCTAssertFalse(target1.wasCalled)
    }

    func testMutipleTargets() {
        let target1 = FakeTarget()
        let target2 = FakeTarget()

        subject.addTarget(target1, action: #selector(FakeTarget.onAction(_:)), for: .primaryAction)
        subject.addTarget(target2, action: #selector(FakeTarget.onAction(_:)), for: .primaryAction)

        
        subject.sendActions(for: .primaryAction)
        
        XCTAssertTrue(target1.wasCalled)
        XCTAssertTrue(target2.wasCalled)
    }
}
