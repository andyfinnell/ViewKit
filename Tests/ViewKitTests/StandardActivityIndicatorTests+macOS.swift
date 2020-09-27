#if canImport(AppKit)
import Foundation
import Cocoa
import XCTest
import ViewKit

final class StandardActivityIndicatorTests: XCTestCase {
    private var subject: StandardActivityIndicator!
    
    override func setUp() {
        super.setUp()
        subject = StandardActivityIndicator()
    }
    
    func test_init() {
        XCTAssertFalse(subject.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(subject.isAnimating)
        XCTAssertTrue(subject.hidesWhenStopped)
    }

    func test_startAnimating_hidesWhenStoppedIsTrue() {
        XCTAssertFalse(subject.isAnimating)
        XCTAssertTrue(subject.isHidden)
        
        subject.startAnimating()

        XCTAssertTrue(subject.isAnimating)
        XCTAssertFalse(subject.isHidden)
    }
    
    func test_startAnimating_hidesWhenStoppedIsFalse() {
        subject.hidesWhenStopped = false
        
        XCTAssertFalse(subject.isAnimating)
        XCTAssertTrue(subject.isHidden)
        
        subject.startAnimating()
        
        XCTAssertTrue(subject.isAnimating)
        XCTAssertTrue(subject.isHidden)
    }

    func test_stopAnimating_hidesWhenStoppedIsTrue() {
        subject.startAnimating()
        
        XCTAssertTrue(subject.isAnimating)
        XCTAssertFalse(subject.isHidden)

        subject.stopAnimating()
        
        XCTAssertFalse(subject.isAnimating)
        XCTAssertTrue(subject.isHidden)
    }
    
    func test_stopAnimating_hidesWhenStoppedIsFalse() {
        subject.startAnimating()
        
        XCTAssertTrue(subject.isAnimating)
        XCTAssertFalse(subject.isHidden)
        
        subject.hidesWhenStopped = false
        
        subject.stopAnimating()
        
        XCTAssertFalse(subject.isAnimating)
        XCTAssertFalse(subject.isHidden)
    }
}

#endif
