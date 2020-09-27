import Foundation
#if canImport(UIKIt)
import UIKit

public final class StandardActivityIndicator: UIActivityIndicatorView, Stylable {
    public struct Style {
        public let color: UIColor
        
        public init(color: UIColor) {
            self.color = color
        }
    }
    
    public static let defaultStyle = Style(color: .systemGray)
    
    public init(isAnimating: Bool = false, id: String? = nil) {
        super.init(style: .large)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.hidesWhenStopped = true
        self.color = StyleSheet.shared.lookup(Self.self).color
        self.isAnimating = isAnimating
        accessibilityIdentifier = id
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var isAnimating: Bool {
        get { super.isAnimating }
        set {
            if newValue {
                self.startAnimating()
            } else {
                self.stopAnimating()
            }
        }
    }
}

#endif
