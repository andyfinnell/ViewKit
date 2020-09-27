#if canImport(AppKit)
import Cocoa
import XCTest
import Combine
import ViewKit

final class StandardTextFieldTests: XCTestCase {
    private var subject: StandardTextField!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        subject = StandardTextField()
        cancellables = Set()
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
    
    func test_textPublisher() {
        var lastValue: String?
        let textExpectation = expectation(description: "text")
        subject.publisher.text.sink { value in
            lastValue = value
            textExpectation.fulfill()
        }.store(in: &cancellables)
        
        subject.text = "frank"
        _ = subject.target?.perform(subject.action, with: subject)

        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertEqual(lastValue, "frank")
    }

}

#endif
