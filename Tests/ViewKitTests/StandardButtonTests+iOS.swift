#if canImport(UIKit)

import UIKit
import XCTest
import ViewKit

final class StandardButtonTests: XCTestCase {
    private var subject: StandardButton!
    
    override func setUp() {
        super.setUp()
        subject = StandardButton(text: "the title")
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
}

#endif
