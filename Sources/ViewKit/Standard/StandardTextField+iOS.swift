#if canImport(UIKit)
import UIKit

public final class StandardTextField: UITextField, Stylable {
    public struct Style {
        public let borderColor: UIColor
        public let focusBorderColor: UIColor
        
        public init(borderColor: UIColor, focusBorderColor: UIColor) {
            self.borderColor = borderColor
            self.focusBorderColor = focusBorderColor
        }
    }
    public static let defaultStyle = Style(borderColor: .separator, focusBorderColor: .opaqueSeparator)
    
    public enum Format {
        case standard
        case email
    }
    private let border = StandardContainerView(backgroundColor: StyleSheet.shared.lookup(StandardTextField.self).borderColor)
    
    public init(format: Format = .standard, placeholder: String? = nil, id: String? = nil) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(border)
        
        NSLayoutConstraint(item: border, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 1.0).isActive = true
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": border]))
        NSLayoutConstraint(item: border, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1.0).isActive = true
        
        switch format {
        case .standard:
            break // nothing to do
        case .email:
            self.keyboardType = .emailAddress
            self.autocorrectionType = .no
            self.autocapitalizationType = .none
            self.textContentType = .emailAddress
        }
        self.placeholder = placeholder
        self.accessibilityIdentifier = id
    }
    
    public override func becomeFirstResponder() -> Bool {
        let returnValue = super.becomeFirstResponder()
        border.backgroundColor = StyleSheet.shared.lookup(Self.self).focusBorderColor
        return returnValue
    }
    
    public override func resignFirstResponder() -> Bool {
        let returnValue = super.resignFirstResponder()
        border.backgroundColor = StyleSheet.shared.lookup(Self.self).borderColor
        return returnValue
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
