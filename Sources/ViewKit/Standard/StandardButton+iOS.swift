#if canImport(UIKit)
import UIKit
import Combine

public final class StandardButton: UIButton, Stylable, Targetable {
    private let activityIndicator = StandardActivityIndicator()
    
    public struct StateStyle {
        public let titleColor: UIColor
        
        public init(titleColor: UIColor) {
            self.titleColor = titleColor
        }
    }
    
    public struct Style {
        public let normal: StateStyle
        public let highlighted: StateStyle
        public let disabled: StateStyle
        
        public init(normal: StateStyle, highlighted: StateStyle, disabled: StateStyle) {
            self.normal = normal
            self.highlighted = highlighted
            self.disabled = disabled
        }
    }
    
    public static let defaultStyle = Style(normal: StateStyle(titleColor: .systemBlue),
                                           highlighted: StateStyle(titleColor: .systemBlue),
                                           disabled: StateStyle(titleColor: .systemGray))
    
    public init(text: String?, id: String? = nil) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(text, for: .normal)
        addSubview(activityIndicator)
        
        let style = StyleSheet.shared.lookup(Self.self)
        setTitleColor(style.normal.titleColor, for: .normal)
        setTitleColor(style.highlighted.titleColor, for: .highlighted)
        setTitleColor(style.disabled.titleColor, for: .disabled)

        NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        accessibilityIdentifier = id
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startAnimating() {
        activityIndicator.startAnimating()
        isEnabled = false
    }
    
    public func stopAnimating() {
        activityIndicator.stopAnimating()
        isEnabled = true
    }
    
    public var isAnimating: Bool {
        get { activityIndicator.isAnimating }
        set {
            if newValue {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
    }
}

public extension PublisherContainer where TargetableType: StandardButton {
    var press: AnyPublisher<Void, Never> {
        ActionPublisher(target: targetable, targetEvent: .touchUpInside).eraseToAnyPublisher()
    }
}
#endif
