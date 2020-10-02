import Foundation

public enum ViewHierarchy {
    case superview(NativeView, subviews: [NativeView])
    case hierarchy(NativeView, subviews: [ViewHierarchy])
    case views([NativeView])
    case controller(NativeViewController)
    case controllers([NativeViewController])
    
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
        case let .controller(controller):
            view.install(view: controller.view)
        case let .controllers(controllers):
            for controller in controllers {
                view.install(view: controller.view)
            }
        }
    }
    
    public func install(on controller: NativeViewController) {
        for viewController in viewControllers {
            controller.addChild(viewController)
        }
    }
}

private extension ViewHierarchy {
    var viewControllers: [NativeViewController] {
        var controllers = [NativeViewController]()
        switch self {
        case let .controller(controller):
            controllers.append(controller)
        case let .controllers(subcontrollers):
            controllers.append(contentsOf: subcontrollers)
        case .hierarchy(_, subviews: let hierarchy):
            let subcontrollers = hierarchy.reduce([]) { $0 + $1.viewControllers }
            controllers.append(contentsOf: subcontrollers)
        case .superview, .views:
            break // can't contain controllers
        }
        return controllers
    }
}
