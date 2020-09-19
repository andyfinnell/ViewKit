import Foundation
import XCTest
@testable import ViewKit

final class LayoutTests: XCTestCase {
    var superview: NativeView!
    var view1: NativeView!
    var view2: NativeView!
    
    override func setUp() {
        super.setUp()
        superview = NativeView()
        view1 = NativeView()
        view2 = NativeView()
        superview.install(view: view1)
        superview.install(view: view2)
    }
    
    func test_halign() {
        let subject = Layout.halign(.leadingGuide, 10.0, .leading(view1))
        XCTAssertEqual(subject.compile(), [LayoutAssembly.h(LayoutAssemblyHAnchor(item: superview, attribute: .leading), LayoutAssemblyHAnchor(item: view1, attribute: .leading), LayoutAssemblyRelation(op: .equal, constant: 10.0))])
    }
    
    func test_valign() {
        let subject = Layout.valign(.topGuide, 10.0, .top(view1))
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: superview, attribute: .top), LayoutAssemblyVAnchor(item: view1, attribute: .top), LayoutAssemblyRelation(op: .equal, constant: 10.0))
            ])
    }

    func test_size_withView() {
        let subject = Layout.size(.width(view1), .height(view1))
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.dimension(LayoutAssemblyDimensionAnchor(item: view1, attribute: .width), LayoutAssemblyDimensionAnchor(item: view1, attribute: .height), LayoutAssemblyRelation(op: .equal, constant: 0.0))
            ])
    }
    
    func test_size_withConstant() {
        let subject = Layout.size(.height(view1), .constant(100))
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.dimension(LayoutAssemblyDimensionAnchor(item: view1, attribute: .height), nil, LayoutAssemblyRelation(op: .equal, constant: 100.0))
            ])
    }

    func test_leading() {
        let subject = Layout.leading(10.0, view1)
        XCTAssertEqual(subject.compile(), [LayoutAssembly.h(LayoutAssemblyHAnchor(item: superview, attribute: .leading), LayoutAssemblyHAnchor(item: view1, attribute: .leading), LayoutAssemblyRelation(op: .equal, constant: 10.0))])
    }
    
    func test_trailing() {
        let subject = Layout.trailing(view1, 10.0)
        XCTAssertEqual(subject.compile(), [LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .trailing), LayoutAssemblyHAnchor(item: superview, attribute: .trailing), LayoutAssemblyRelation(op: .equal, constant: 10.0))])
    }

    func test_hmargin() {
        let subject = Layout.hmargin(20, view1, 10.0)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: superview, attribute: .leading), LayoutAssemblyHAnchor(item: view1, attribute: .leading), LayoutAssemblyRelation(op: .equal, constant: 20.0)),
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .trailing), LayoutAssemblyHAnchor(item: superview, attribute: .trailing), LayoutAssemblyRelation(op: .equal, constant: 10.0))
            ])
    }
    
    func test_hmarginAtLeast() {
        let subject = Layout.hmarginAtLeast(20, view1, 10.0)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: superview, attribute: .leading), LayoutAssemblyHAnchor(item: view1, attribute: .leading), LayoutAssemblyRelation(op: .greaterThanEqual, constant: 20.0)),
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .trailing), LayoutAssemblyHAnchor(item: superview, attribute: .trailing), LayoutAssemblyRelation(op: .greaterThanEqual, constant: 10.0))
            ])
    }

    func test_hmarginTrailingAtLeast() {
        let subject = Layout.hmarginTrailingAtLeast(20, view1, 10.0)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: superview, attribute: .leading), LayoutAssemblyHAnchor(item: view1, attribute: .leading), LayoutAssemblyRelation(op: .equal, constant: 20.0)),
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .trailing), LayoutAssemblyHAnchor(item: superview, attribute: .trailing), LayoutAssemblyRelation(op: .greaterThanEqual, constant: 10.0))
            ])
    }

    func test_width_withView() {
        let subject = Layout.width(view1, .width(view2))
        XCTAssertEqual(subject.compile(), [LayoutAssembly.dimension(LayoutAssemblyDimensionAnchor(item: view1, attribute: .width), LayoutAssemblyDimensionAnchor(item: view2, attribute: .width), LayoutAssemblyRelation(op: .equal, constant: 0.0))])
    }
    
    func test_width_withConstant() {
        let subject = Layout.width(view1, .constant(50))
        XCTAssertEqual(subject.compile(), [LayoutAssembly.dimension(LayoutAssemblyDimensionAnchor(item: view1, attribute: .width), nil, LayoutAssemblyRelation(op: .equal, constant: 50.0))])
    }

    func test_maximumWidth_withView() {
        let subject = Layout.maximumWidth(view1, .width(view2))
        XCTAssertEqual(subject.compile(), [LayoutAssembly.dimension(LayoutAssemblyDimensionAnchor(item: view1, attribute: .width), LayoutAssemblyDimensionAnchor(item: view2, attribute: .width), LayoutAssemblyRelation(op: .lessThanEqual, constant: 0.0))])
    }
    
    func test_maximumWidth_withConstant() {
        let subject = Layout.maximumWidth(view1, .constant(50))
        XCTAssertEqual(subject.compile(), [LayoutAssembly.dimension(LayoutAssemblyDimensionAnchor(item: view1, attribute: .width), nil, LayoutAssemblyRelation(op: .lessThanEqual, constant: 50.0))])
    }

    func test_hcenter() {
        let subject = Layout.hcenter(view1)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .hcenter), LayoutAssemblyHAnchor(item: superview, attribute: .hcenter), LayoutAssemblyRelation(op: .equal, constant: 0.0))
            ])
    }
    
    func test_hcenterContainer() {
        let subject = Layout.hcenterContainer(view1, minMargin: 15, maxWidth: 500)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .hcenter), LayoutAssemblyHAnchor(item: superview, attribute: .hcenter), LayoutAssemblyRelation(op: .equal, constant: 0.0)),
            LayoutAssembly.dimension(LayoutAssemblyDimensionAnchor(item: view1, attribute: .width), nil, LayoutAssemblyRelation(op: .lessThanEqual, constant: 500.0)),
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: superview, attribute: .leading), LayoutAssemblyHAnchor(item: view1, attribute: .leading), LayoutAssemblyRelation(op: .greaterThanEqual, constant: 15.0)),
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .trailing), LayoutAssemblyHAnchor(item: superview, attribute: .trailing), LayoutAssemblyRelation(op: .greaterThanEqual, constant: 15.0)),
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: superview, attribute: .leading), LayoutAssemblyHAnchor(item: view1, attribute: .leading), LayoutAssemblyRelation(op: .equal, constant: 15.0, priority: .high)),
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .trailing), LayoutAssemblyHAnchor(item: superview, attribute: .trailing), LayoutAssemblyRelation(op: .equal, constant: 15.0, priority: .high))
            ])
    }
    
    func test_row() {
        let subject = Layout.row([
            .leadingGuide,
            .space(10),
            .view(view1),
            .space(5),
            .view(view2),
            .trailingGuide
            ])
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: superview, attribute: .leading), LayoutAssemblyHAnchor(item: view1, attribute: .leading), LayoutAssemblyRelation(op: .equal, constant: 10.0)),
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .trailing), LayoutAssemblyHAnchor(item: view2, attribute: .leading), LayoutAssemblyRelation(op: .equal, constant: 5.0)),
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view2, attribute: .trailing), LayoutAssemblyHAnchor(item: superview, attribute: .trailing), LayoutAssemblyRelation(op: .equal, constant: 0.0)),
            ])
    }

    func test_top() {
        let subject = Layout.top(10, view1)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: superview, attribute: .top), LayoutAssemblyVAnchor(item: view1, attribute: .top), LayoutAssemblyRelation(op: .equal, constant: 10.0))
            ])
    }
    
    func test_bottom() {
        let subject = Layout.bottom(view1, 20)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: view1, attribute: .bottom), LayoutAssemblyVAnchor(item: superview, attribute: .bottom), LayoutAssemblyRelation(op: .equal, constant: 20.0))
            ])
    }

    func test_vmargin() {
        let subject = Layout.vmargin(10, view1, 20)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: superview, attribute: .top), LayoutAssemblyVAnchor(item: view1, attribute: .top), LayoutAssemblyRelation(op: .equal, constant: 10.0)),
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: view1, attribute: .bottom), LayoutAssemblyVAnchor(item: superview, attribute: .bottom), LayoutAssemblyRelation(op: .equal, constant: 20.0))
            ])
    }

    func test_vmarginAtLeast() {
        let subject = Layout.vmarginAtLeast(20, view1, 10.0)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: superview, attribute: .top), LayoutAssemblyVAnchor(item: view1, attribute: .top), LayoutAssemblyRelation(op: .greaterThanEqual, constant: 20.0)),
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: view1, attribute: .bottom), LayoutAssemblyVAnchor(item: superview, attribute: .bottom), LayoutAssemblyRelation(op: .greaterThanEqual, constant: 10.0))
            ])
    }

    func test_height_withView() {
        let subject = Layout.height(view1, .width(view2))
        XCTAssertEqual(subject.compile(), [LayoutAssembly.dimension(LayoutAssemblyDimensionAnchor(item: view1, attribute: .height), LayoutAssemblyDimensionAnchor(item: view2, attribute: .width), LayoutAssemblyRelation(op: .equal, constant: 0.0))])
    }
    
    func test_height_withConstant() {
        let subject = Layout.height(view1, .constant(50))
        XCTAssertEqual(subject.compile(), [LayoutAssembly.dimension(LayoutAssemblyDimensionAnchor(item: view1, attribute: .height), nil, LayoutAssemblyRelation(op: .equal, constant: 50.0))])
    }

    func test_vcenter() {
        let subject = Layout.vcenter(view1)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: view1, attribute: .vcenter), LayoutAssemblyVAnchor(item: superview, attribute: .vcenter), LayoutAssemblyRelation(op: .equal, constant: 0.0))
            ])
    }

    func test_column() {
        let subject = Layout.column([
            .topGuide,
            .space(10),
            .view(view1),
            .space(5),
            .view(view2),
            .bottomGuide
            ])
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: superview, attribute: .top), LayoutAssemblyVAnchor(item: view1, attribute: .top), LayoutAssemblyRelation(op: .equal, constant: 10.0)),
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: view1, attribute: .bottom), LayoutAssemblyVAnchor(item: view2, attribute: .top), LayoutAssemblyRelation(op: .equal, constant: 5.0)),
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: view2, attribute: .bottom), LayoutAssemblyVAnchor(item: superview, attribute: .bottom), LayoutAssemblyRelation(op: .equal, constant: 0.0)),
            ])
    }

    func test_center() {
        let subject = Layout.center(view1)
        XCTAssertEqual(subject.compile(), [
            LayoutAssembly.h(LayoutAssemblyHAnchor(item: view1, attribute: .hcenter), LayoutAssemblyHAnchor(item: superview, attribute: .hcenter), LayoutAssemblyRelation(op: .equal, constant: 0.0)),
            LayoutAssembly.v(LayoutAssemblyVAnchor(item: view1, attribute: .vcenter), LayoutAssemblyVAnchor(item: superview, attribute: .vcenter), LayoutAssemblyRelation(op: .equal, constant: 0.0))
            ])
    }
}
