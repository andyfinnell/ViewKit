#if canImport(UIKit)
import UIKit

public final class StandardContainerView: UIView {
    public init(backgroundColor: UIColor = .clear) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#endif
