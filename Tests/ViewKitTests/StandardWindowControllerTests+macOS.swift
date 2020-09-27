#if canImport(AppKit)
import Cocoa
import XCTest
import ViewKit

final class StandardWindowControllerTests: XCTest {
    func testInit_kindEqualsFixedSize() {
        let subject = StandardWindowController(kind: .fixedSize, autosaveName: "test")
        XCTAssertEqual(subject.window!.styleMask, [.titled])
        XCTAssertEqual(subject.windowFrameAutosaveName, "test")
    }
    
    func testInit_kindEqualsResizable() {
        let subject = StandardWindowController(kind: .resizeable, autosaveName: "test")
        XCTAssertEqual(subject.window!.styleMask, [.titled, .closable, .miniaturizable, .resizable])
        XCTAssertEqual(subject.windowFrameAutosaveName, "test")
    }
}
#endif
