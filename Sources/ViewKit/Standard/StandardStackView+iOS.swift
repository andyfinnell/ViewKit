import Foundation
#if canImport(UIKit)
import UIKit

public final class StandardStackView: UIStackView {
    public init(axis: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#endif
