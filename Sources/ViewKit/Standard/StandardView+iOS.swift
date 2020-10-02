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
    
    open var hierarchy: ViewHierarchy {
        return .views([])
    }
    
    open var layout: [Layout] {
        return []
    }
}
#endif
