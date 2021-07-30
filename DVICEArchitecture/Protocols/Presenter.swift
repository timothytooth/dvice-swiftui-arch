import Foundation
import UIKit
import SwiftUI

///The main purpose of this interface is to pass view component references between DVICE modules. It also prevents view types from leaking out of the view layer of a module.
///
///All `present(_:)` APIs are intentionally overloaded and default implemented to allow clients to pass any supported view controller type without knowing whether the presenter supports that type.
protocol Presenter: AnyObject {
    func present<ContentView: View>(_ view: ContentView, animated: Bool, completion: (() -> Void)?)
    func present<ContentView: View>(_ view: ContentView)
    func dismiss(completion: (() -> Void)?)
}

///While conformance to all `present` APIs is made optional via default implementation here, conformers must implement at least `present<ContentView: View>` or a "higher" level API based on the fallback chain.
extension Presenter {
    func present<ContentView: View>(_ view: ContentView, animated: Bool, completion: (() -> Void)?) {
        assertionFailure("not supported")
    }
    
    func present<ContentView: View>(_ view: ContentView) {
        assertionFailure("not supported")
    }
    
    func dismiss(completion: (() -> Void)? = nil) {
        assertionFailure("not supported")
    }
}
