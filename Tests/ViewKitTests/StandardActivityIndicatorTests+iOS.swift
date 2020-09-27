#if canImport(UIKit)

import UIKit
import XCTest
import ViewKit

final class StandardActivityIndicatorTests: XCTestCase {
    
    func test_init() {
        let subject = StandardActivityIndicator()
        XCTAssertFalse(subject.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(subject.isAnimating)
        XCTAssertTrue(subject.hidesWhenStopped)
    }
}

#endif
