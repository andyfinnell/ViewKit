#if canImport(Appkit)
import Cocoa

public final class StandardLabel: NSTextField {
    public enum Line {
        case single
        case multiline
        case exactly(Int)
    }

    public init(textStyle: NSFont.TextStyle = .body, text: String? = nil, line: Line = .single, textColor: NSColor = .textColor, isHidden: Bool = false, id: String? = nil) {
        super.init(frame: .zero)
        self.isEditable = false
        self.isBordered = false
        self.isBezeled = false
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = NSFont.preferredFont(forTextStyle: textStyle)
        self.stringValue = text ?? ""
        setAccessibilityIdentifier(id)
        switch line {
        case .single:
            self.numberOfLines = 1
        case .multiline:
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
        case let .exactly(lines):
            self.numberOfLines = lines
            self.lineBreakMode = .byWordWrapping
        }
        self.textColor = textColor
        self.isHidden = isHidden
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var text: String? {
        get { stringValue }
        set { stringValue = newValue ?? "" }
    }
    
    public var numberOfLines: Int {
        get { maximumNumberOfLines }
        set { maximumNumberOfLines = newValue }
    }
}

#endif
