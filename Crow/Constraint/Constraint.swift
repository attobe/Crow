import Foundation
import UIKit

public protocol Constraint {
    func build() -> [NSLayoutConstraint]
}

public func && (lhs: Constraint, rhs: Constraint) -> CollectionConstraint {
    let constraint = CollectionConstraint()
    constraint.append(lhs)
    constraint.append(rhs)
    return constraint
}
