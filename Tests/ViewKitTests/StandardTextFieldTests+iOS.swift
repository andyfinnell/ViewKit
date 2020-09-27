#if canImport(UIKit)

import UIKit
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
    
    func test_textPublisher() {
        var lastValue: String?
        let textExpectation = expectation(description: "text")
        subject.publisher.text.sink { value in
            lastValue = value
            textExpectation.fulfill()
        }.store(in: &cancellables)
        
        subject.text = "frank"
        subject.testActions(for: .valueChanged)
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertEqual(lastValue, "frank")
    }

}

#endif
