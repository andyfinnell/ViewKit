import Foundation
#if canImport(AppKit)
import AppKit

public final class StandardWindowController: NSWindowController {
    public enum Kind {
        case resizeable
        case fixedSize
        
        fileprivate var styleMask: NSWindow.StyleMask {
            switch self {
            case .resizeable:
                return [.titled, .closable, .miniaturizable, .resizable]
            case .fixedSize:
                return [.titled]
            }
        }
    }
    
    public init(kind: Kind, autosaveName: NSWindow.FrameAutosaveName? = nil) {
        let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 100, height: 50), styleMask: kind.styleMask, backing: .buffered, defer: true)
        window.isReleasedWhenClosed = true
        if let autosaveName = autosaveName {
            window.setFrameAutosaveName(autosaveName)
        }
        super.init(window: window)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#endif
