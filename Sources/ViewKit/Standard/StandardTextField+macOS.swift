import Foundation
#if canImport(AppKit)
import AppKit

public final class StandardTextField: NSTextField {
    public enum Format {
        case standard
        case email
    }

    public init(format: Format = .standard, placeholder: String? = nil, id: String? = nil) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        setAccessibilityIdentifier(id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var text: String? {
        get { stringValue }
        set { stringValue = newValue ?? "" }
    }

    public var placeholder: String? {
        get { placeholderString }
        set { placeholderString = newValue }
    }
}

#endif
