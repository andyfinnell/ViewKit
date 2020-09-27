#if canImport(AppKit)
import Cocoa
import XCTest
import ViewKit

final class StandardLabelTests: XCTestCase {
    private var subject: StandardLabel!
    
    override func setUp() {
        super.setUp()
        subject = StandardLabel(textStyle: .body, text: "the text")
    }
    
    func test_init() {
        XCTAssertEqual(subject.text, "the text")
        XCTAssertFalse(subject.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(subject.font, NSFont.preferredFont(forTextStyle: .body))
        XCTAssertFalse(subject.isEditable)
        XCTAssertFalse(subject.isBordered)
        XCTAssertFalse(subject.isBezeled)
        XCTAssertEqual(subject.backgroundColor, NSColor.clear)
    }
    
    func test_text() {
        subject.text = nil
        XCTAssertEqual(subject.text, "")
        XCTAssertEqual(subject.stringValue, "")
        
        subject.text = "bob"
        XCTAssertEqual(subject.text, "bob")
        XCTAssertEqual(subject.stringValue, "bob")
    }
    
    func test_numberOfLines() {
        subject.numberOfLines = 0
        XCTAssertEqual(subject.numberOfLines, 0)
        XCTAssertEqual(subject.maximumNumberOfLines, 0)

        subject.numberOfLines = 2
        XCTAssertEqual(subject.numberOfLines, 2)
        XCTAssertEqual(subject.maximumNumberOfLines, 2)
    }
}

#endif
