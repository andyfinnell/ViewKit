#if canImport(AppKit)
import Cocoa
import XCTest
import Combine
import ViewKit

final class StandardButtonTests: XCTestCase {
    private var subject: StandardButton!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        subject = StandardButton(text: "the title")
        cancellables = Set()
    }
    
    func test_initDefault() {
        XCTAssertEqual(subject.title, "the title")
        XCTAssertFalse(subject.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(subject.keyEquivalent, "")
    }
    
    func test_init_isDefaultTrue() {
        subject = StandardButton(text: "the title", isDefault: true)
        XCTAssertEqual(subject.title, "the title")
        XCTAssertFalse(subject.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(subject.keyEquivalent, "\r")
    }

    func test_startAnimating() {
        XCTAssertFalse(subject.isAnimating)
        subject.startAnimating()
        XCTAssertTrue(subject.isAnimating)
    }
    
    func test_stopAnimating() {
        subject.startAnimating()
        XCTAssertTrue(subject.isAnimating)
        subject.stopAnimating()
        XCTAssertFalse(subject.isAnimating)
    }
    
    func test_pressPublisher() {
        var wasPressed = false
        let pressExpectation = expectation(description: "pressed")
        subject.publisher.press.sink {
            wasPressed = true
            pressExpectation.fulfill()
        }.store(in: &cancellables)
        _ = subject.target?.perform(subject.action, with: subject)
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertTrue(wasPressed)
    }
}

#endif
