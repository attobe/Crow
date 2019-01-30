import Foundation
import UIKit

extension UILayoutSupport {
    public var crow: Crow {
        return Crow(view: self)
    }

    @discardableResult
    public func crowed(_ block: (Crow) -> Constraint) -> Self {
        crow.expr(block).activate()
        return self
    }
}
