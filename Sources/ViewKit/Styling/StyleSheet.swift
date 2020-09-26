import Foundation

public final class StyleSheet {
    private var styles = [StyleId: StyleContainerProtocol]()
    
    public static let shared = StyleSheet()
    
    init() {}
    
    public func define<T: Stylable>(_ style: T.StyleType, for stylable: T.Type) {
        let container = StyleContainer<T>(style: style)
        styles[T.styleId] = container
    }
    
    public func lookup<T: Stylable>(_ stylable: T.Type) -> T.StyleType {
        guard let container = styles[T.styleId] else {
            return T.defaultStyle
        }
        return container.lookup(stylable)
    }
}

private protocol StyleContainerProtocol {
    func lookup<L: Stylable>(_ stylable: L.Type) -> L.StyleType
}

private extension StyleSheet {
    struct StyleContainer<T: Stylable>: StyleContainerProtocol {
        private let style: T.StyleType
        
        init(style: T.StyleType) {
            self.style = style
        }
        
        func lookup<L: Stylable>(_ stylable: L.Type) -> L.StyleType {
            style as? L.StyleType ?? L.defaultStyle
        }
    }
}
