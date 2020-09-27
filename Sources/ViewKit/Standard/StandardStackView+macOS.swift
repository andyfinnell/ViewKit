import Foundation
#if canImport(AppKit)
import AppKit

public final class StandardStackView: NSStackView {
    public init(axis: NSUserInterfaceLayoutOrientation = .vertical) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.orientation = axis
    }
    
    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#endif
