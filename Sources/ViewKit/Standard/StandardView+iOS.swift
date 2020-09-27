#if canImport(UIKit)
import UIKit

open class StandardView: UIView {
    public init() {
        super.init(frame: .zero)
        backgroundColor = .white
        hierarchy.install(on: self)
        let constraints = layout.compile().constraints()
        NSLayoutConstraint.activate(constraints)
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
