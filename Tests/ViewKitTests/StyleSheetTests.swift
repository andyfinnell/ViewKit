import Foundation
import XCTest
@testable import ViewKit

private struct FakeStyle: Equatable {
    let thing: String
    let stuff: Bool
}

private final class FakeStylable: Stylable {
    static let defaultStyle = FakeStyle(thing: "Default", stuff: true)
}

final class StyleSheetTests: XCTestCase {
    private var subject: StyleSheet!
    
    override func setUp() {
        super.setUp()
        subject = StyleSheet()
    }
    
    func testDefaultStyle() {
        let defaultValue = subject.lookup(FakeStylable.self)
        XCTAssertEqual(defaultValue, FakeStylable.defaultStyle)
    }
    
    func testStoredStyle() {
        let definedValue = FakeStyle(thing: "Not the default", stuff: false)
        subject.define(definedValue, for: FakeStylable.self)
        
        let actualValue = subject.lookup(FakeStylable.self)
        XCTAssertEqual(actualValue, definedValue)
    }
}
