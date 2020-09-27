import Foundation

#if canImport(AppKit)
import AppKit

open class StandardView: NSView {
    public init() {
        super.init(frame: .zero)
        hierarchy.install(on: self)
        let constraints = layout.compile().constraints()
        NSLayoutConstraint.activate(constraints)
        self.frame.size = fittingSize
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var hierarchy: ViewHierarchy {
        return .views([])
    }

    public var layout: [Layout] {
        return []
    }
}

#endif
