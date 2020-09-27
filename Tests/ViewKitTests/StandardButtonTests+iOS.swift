#if canImport(UIKit)

import UIKit
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
    
    func test_init() {
        XCTAssertEqual(subject.currentTitle, "the title")
        XCTAssertFalse(subject.translatesAutoresizingMaskIntoConstraints)
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
        
        subject.testActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertTrue(wasPressed)
    }
}

#endif
