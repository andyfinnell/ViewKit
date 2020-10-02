import Foundation
#if canImport(UIKit)
import UIKit

open class StandardViewController: UIViewController {
    private let realView: StandardView
    
    public init(realView: StandardView) {
        self.realView = realView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = realView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        realView.hierarchy.install(on: self)
    }
}

#endif
