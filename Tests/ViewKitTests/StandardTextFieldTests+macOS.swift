#if canImport(AppKit)
import Cocoa
import XCTest
import ViewKit

final class StandardTextFieldTests: XCTestCase {
    private var subject: StandardTextField!
    
    override func setUp() {
        super.setUp()
        subject = StandardTextField()
    }
    
    func test_init() {
        XCTAssertFalse(subject.translatesAutoresizingMaskIntoConstraints)
    }
    
    func test_text() {
        subject.text = nil
        XCTAssertEqual(subject.text, "")
        XCTAssertEqual(subject.stringValue, "")
        
        subject.text = "bob"
        XCTAssertEqual(subject.text, "bob")
        XCTAssertEqual(subject.stringValue, "bob")
    }

    func test_placeholder() {
        subject.placeholder = nil
        XCTAssertNil(subject.placeholder)
        XCTAssertNil(subject.placeholderString)
        
        subject.placeholder = "bob"
        XCTAssertEqual(subject.placeholder, "bob")
        XCTAssertEqual(subject.placeholderString, "bob")
    }
}

#endif
