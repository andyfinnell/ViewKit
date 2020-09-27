#if canImport(UIKit)
import UIKit

public final class StandardLabel: UILabel {
    public enum Line {
        case single
        case multiline
        case exactly(Int)
    }
    
    public init(textStyle: UIFont.TextStyle = .body, text: String? = nil, line: Line = .single, textColor: UIColor = .label, isHidden: Bool = false, id: String? = nil) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.preferredFont(forTextStyle: textStyle)
        self.text = text
        self.accessibilityIdentifier = id
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
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
