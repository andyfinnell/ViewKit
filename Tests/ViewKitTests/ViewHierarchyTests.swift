import Foundation
import XCTest
@testable import ViewKit

final class ViewHierarchyTests: XCTestCase {
    var installView: NativeView!
    
    override func setUp() {
        super.setUp()
        installView = NativeView()
    }
    
    func testInstall_hierarchy_sameAsInstall() {
        let view1 = NativeView()
        let view2 = NativeView()
        let view3 = NativeView()
        let subject = ViewHierarchy.hierarchy(installView, subviews: [
                .hierarchy(view1, subviews: [.views([view2])]),
                .views([view3])
            ])
        subject.install(on: installView)
        
        XCTAssertTrue(view1.superview === installView)
        XCTAssertTrue(view2.superview === view1)
        XCTAssertTrue(view3.superview === installView)
    }
    
    func testInstall_hierarchy_differentFromInstall() {
        let view0 = NativeView()
        let view1 = NativeView()
        let view2 = NativeView()
        let view3 = NativeView()
        let subject = ViewHierarchy.hierarchy(view0, subviews: [
            .hierarchy(view1, subviews: [.views([view2])]),
            .views([view3])
            ])
        subject.install(on: installView)
        
        XCTAssertTrue(view0.superview === installView)
        XCTAssertTrue(view1.superview === view0)
        XCTAssertTrue(view2.superview === view1)
        XCTAssertTrue(view3.superview === view0)
    }
    
    func testInstall_superview_sameAsInstall() {
        let view1 = NativeView()
        let view2 = NativeView()
        let view3 = NativeView()
        let subject = ViewHierarchy.superview(installView, subviews: [view1, view2, view3])
        
        subject.install(on: installView)
        
        XCTAssertTrue(view1.superview === installView)
        XCTAssertTrue(view2.superview === installView)
        XCTAssertTrue(view3.superview === installView)
    }
    
    func testInstall_supervew_differentFromInstall() {
        let view0 = NativeView()
        let view1 = NativeView()
        let view2 = NativeView()
        let view3 = NativeView()
        let subject = ViewHierarchy.superview(view0, subviews: [view1, view2, view3])
        subject.install(on: installView)
        
        XCTAssertTrue(view0.superview === installView)
        XCTAssertTrue(view1.superview === view0)
        XCTAssertTrue(view2.superview === view0)
        XCTAssertTrue(view3.superview === view0)
    }

    func testInstall_views() {
        let view1 = NativeView()
        let view2 = NativeView()
        let view3 = NativeView()
        let subject = ViewHierarchy.views([view1, view2, view3])
        subject.install(on: installView)
        
        XCTAssertTrue(view1.superview === installView)
        XCTAssertTrue(view2.superview === installView)
        XCTAssertTrue(view3.superview === installView)
    }
}
