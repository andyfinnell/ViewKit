import Foundation
#if canImport(AppKit)
import AppKit

public final class StandardActivityIndicator: NSProgressIndicator {
    public init(isAnimating: Bool = false, id: String? = nil) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.style = .spinning
        self.isHidden = true
        setAccessibilityIdentifier(id)
        sizeToFit()
        if isAnimating {
            self.startAnimating()
        } else {
            self.stopAnimating()
        }
    }
    
    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var isAnimating: Bool {
        get { animationState == .animating }
        set {
            if newValue {
                self.startAnimating()
            } else {
                self.stopAnimating()
            }
        }
    }

    private enum State {
        case animating
        case stopped
    }
    private var animationState: State = .stopped {
        didSet {
            animatingDidChange()
        }
    }
    
    public var hidesWhenStopped = true
    
    public func startAnimating() {
        guard animationState == .stopped else {
            return
        }
        
        startAnimation(nil)
        animationState = .animating
    }
    
    public func stopAnimating() {
        guard animationState == .animating else {
            return
        }
        stopAnimation(nil)
        animationState = .stopped
    }
    
    private func animatingDidChange() {
        if hidesWhenStopped {
            isHidden = animationState == .stopped
        }
    }
}

#endif
