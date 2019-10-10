
import SwiftUI
import UIKit

@propertyWrapper
class SwiftUIView<Value, Parent> where Value: View, Parent: UIViewController {

    private weak var vc: UIHostingController<Value>?

    var wrappedValue: Value? {
        get {
            return nil
        }
        set {
            guard let newValue = newValue, vc == nil else {
                vc?.willMove(toParent: nil)
                vc?.removeFromParent()
                vc?.view.removeFromSuperview()
                return
            }
            let vc = UIHostingController(rootView: newValue)
            self.vc = vc
            parent[keyPath: container].addSubview(vc.view)
            vc.view.frame = parent[keyPath: container].bounds
            parent.addChild(vc)
            vc.didMove(toParent: parent)
        }
    }

    var projectedValue: SwiftUIView<Value, Parent> { return self }

    weak var parent: Parent!
    var container: ReferenceWritableKeyPath<Parent, UIView>!

}
