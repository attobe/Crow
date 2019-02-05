import Foundation
import UIKit

public struct SingleConstraint<AnchorType: Anchor>: Constraint {
    public typealias ItemType = Item<AnchorType>
    public typealias ConstantType = AnchorType.ConstantType

    public let item: ItemType
    public let relation: NSLayoutConstraint.Relation
    public let multiplier: CGFloat
    public let constant: ConstantType
    public let toItem: ItemType?
    public let priority: UILayoutPriority

    public init(left l: ConstraintExpression<AnchorType>,
                relation: NSLayoutConstraint.Relation,
                right r: ConstraintExpression<AnchorType>) {
        let item: ItemType
        let left: ConstraintExpression<AnchorType>
        let right: ConstraintExpression<AnchorType>
        if let i = l.item {
            item = i
            left = l
            right = r
        } else if let i = r.item {
            item = i
            left = r
            right = l
        } else {
            fatalError("no item found")
        }

        // i1 * m1 + c1 = i2 * m2 + c2
        //           i1 = i2 * m2 / m1 + (c2 - c1) / m1
        let multiplier = right.multiplier / left.multiplier
        let constant = (right.constant - left.constant) * (1 / left.multiplier)
        self.init(item: item, relation: relation, multiplier: multiplier, constant: constant, toItem: right.item)
    }

    public init(left: ConstraintExpression<AnchorType>, relation: NSLayoutConstraint.Relation, right: ConstantType) {
        self.init(left: left, relation: relation, right: ConstraintExpression(constant: right))
    }

    public init(item: ItemType,
                relation: NSLayoutConstraint.Relation,
                multiplier: CGFloat,
                constant: ConstantType,
                toItem: ItemType?,
                priority: UILayoutPriority = .required) {
        self.item = item
        self.relation = relation
        self.multiplier = multiplier
        self.constant = constant
        self.toItem = toItem
        self.priority = priority
    }

    public func with(priority: UILayoutPriority) -> SingleConstraint {
        return SingleConstraint(item: item, relation: relation, multiplier: multiplier, constant: constant, toItem: toItem, priority: priority)
    }

    public func build() -> [NSLayoutConstraint] {
        let attributedConstants = item.anchor.expand(constant: constant)
        let toAttributes = toItem?.anchor.attributes
        return attributedConstants.enumerated().map { offset, attributedConstant -> NSLayoutConstraint in
            let toView = toItem?.view
            let toAttribute = toAttributes?[offset]
            let constraint = NSLayoutConstraint(item: item.view,
                                                attribute: attributedConstant.attribute,
                                                relatedBy: relation,
                                                toItem: toView,
                                                attribute: toAttribute ?? attributedConstant.attribute,
                                                multiplier: multiplier,
                                                constant: attributedConstant.constant)
            constraint.priority = priority
            return constraint
        }
    }
}
