import Foundation
import UIKit

public protocol Constraint: CustomStringConvertible {
    func build() -> [NSLayoutConstraint]
}

extension Constraint {
    public func activate() -> [NSLayoutConstraint] {
        let constraints = build()
        constraints.forEach { $0.isActive = true }
        return constraints
    }
}

public func && (lhs: Constraint, rhs: Constraint) -> CollectionConstraint {
    let constraint = CollectionConstraint()
    constraint.append(lhs)
    constraint.append(rhs)
    return constraint
}
