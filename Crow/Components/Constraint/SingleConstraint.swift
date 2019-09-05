import Foundation
import UIKit

public struct SingleConstraint<AnchorType: Anchor>: Constraint {
    public typealias ItemType = Item<AnchorType>
    public typealias ConstantType = AnchorType.ConstantType

    public let left: Expression<AnchorType>
    public let relation: NSLayoutConstraint.Relation
    public let right: Expression<AnchorType>
    public let priority: UILayoutPriority

    public var description: String {
        let op: String
        switch relation {
        case .equal:
            op = "=="
        case .greaterThanOrEqual:
            op = ">="
        case .lessThanOrEqual:
            op = "<="
        @unknown default:
            op = "?"
        }

        let expr = "\(left) \(op) \(right)"
        if priority == .required {
            return expr
        } else if priority == .defaultLow {
            return "(\(expr))l"
        } else if priority == .defaultHigh {
            return "(\(expr))h"
        } else {
            return "(\(expr))(priority=\(priority.rawValue))"
        }
    }

    public init(left: Expression<AnchorType>, relation: NSLayoutConstraint.Relation, right: ConstantType) {
        self.init(left: left, relation: relation, right: Expression(constant: right))
    }

    public init(left: Expression<AnchorType>,
                relation: NSLayoutConstraint.Relation,
                right: Expression<AnchorType>,
                priority: UILayoutPriority = .required) {
        self.left = left
        self.relation = relation
        self.right = right
        self.priority = priority
    }

    public func with(priority: UILayoutPriority) -> SingleConstraint {
        return SingleConstraint(left: left, relation: relation, right: right, priority: priority)
    }

    public func build() -> [NSLayoutConstraint] {
        let item: ItemType
        let left: Expression<AnchorType>
        let right: Expression<AnchorType>
        if let i = self.left.item {
            item = i
            left = self.left
            right = self.right
        } else if let i = self.right.item {
            item = i
            left = self.right
            right = self.left
        } else {
            fatalError("no item found")
        }

        // i1 * m1 + c1 [relation] i2 * m2 + c2
        //           i1 [relation] i2 * m2 / m1 + (c2 - c1) / m1

        // m2 / m1
        let multiplier = right.multiplier / left.multiplier

        // (c2 - c1) / m1
        let baseConstant = (right.constant - left.constant) * (1.0 / left.multiplier)

        let toAnchors = right.item?.anchor.flatten()
        return item.anchor.flatten().enumerated().compactMap { offset, anchor -> NSLayoutConstraint? in
            guard let constant = anchor.transform(constant: baseConstant) else {
                assertionFailure("incompatible constant found - \(self)")
                return nil
            }

            let constraint = NSLayoutConstraint(item: item.view,
                                                attribute: anchor.attribute,
                                                relatedBy: anchor.transform(relation: self.relation),
                                                toItem: right.item?.view,
                                                attribute: toAnchors?[offset].attribute ?? anchor.attribute,
                                                multiplier: multiplier,
                                                constant: constant)
            constraint.priority = priority
            return constraint
        }
    }
}
