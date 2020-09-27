#if canImport(AppKit)
import AppKit

public final class StandardContainerView: NSView {
    public var backgroundColor: NSColor? = nil {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    public init(backgroundColor: NSColor = .clear) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
    }
    
    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        guard let color = backgroundColor else {
            return
        }
        color.setFill()
        NSBezierPath(rect: bounds).fill()
    }
}

#endif
