#if canImport(UIKit)

import UIKit
import XCTest
import ViewKit

final class StandardTextFieldTests: XCTestCase {
    
    func test_init() {
        let subject = StandardTextField()
        XCTAssertFalse(subject.translatesAutoresizingMaskIntoConstraints)
    }
}

#endif
