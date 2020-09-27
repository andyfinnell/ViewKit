#if canImport(UIKit)
import UIKit
import XCTest
import ViewKit

final class StandardLabelTests: XCTestCase {
    
    func test_init() {
        let subject = StandardLabel(textStyle: .body, text: "the text")
        XCTAssertEqual(subject.text, "the text")
        XCTAssertFalse(subject.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(subject.font, UIFont.preferredFont(forTextStyle: .body))
    }
}
#endif
