import Foundation

public enum ViewHierarchy {
    case superview(NativeView, subviews: [NativeView])
    case hierarchy(NativeView, subviews: [ViewHierarchy])
    case views([NativeView])
    
    public func install(on view: NativeView) {
        switch self {
        case let .superview(superview, subviews: subviews):
            if superview !== view {
                view.install(view: superview)
            }
            for subview in subviews {
                superview.install(view: subview)
            }

        case let .hierarchy(superview, subviews: subviews):
            if superview !== view {
                view.install(view: superview)
            }
            for subview in subviews {
                subview.install(on: superview)
            }
            
        case let .views(subviews):
            for subview in subviews {
                view.install(view: subview)
            }
        }
    }
}
