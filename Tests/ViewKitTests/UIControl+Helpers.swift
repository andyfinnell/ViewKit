#if canImport(UIKit)
import UIKit
import XCTest

extension UIControl {
    // We don't have an app host, which means there's no UIApplication to
    //  invoke actions on behalf of UIControler.sendActions(for:). Therefore,
    //  we have to do this ourselves.
    func testActions(for event: UIControl.Event) {
        if #available(iOS 14.0, *) {
            enumerateEventHandlers { action, targetActionPair, events, stop in
                guard events.contains(event) else { return }
                if let pair = targetActionPair, let target = pair.0 as AnyObject? {
                    _ = target.perform(pair.1, with: self)
                }
            }
        } else {
            XCTFail("Must run on iOS 14 or greater")
        }

    }
}

#endif
