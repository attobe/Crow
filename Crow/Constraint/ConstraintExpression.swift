import Foundation
import UIKit

public struct ConstraintExpression<AnchorType: Anchor> {
    public let item: Item<AnchorType>?
    public var constant: AnchorType.ConstantType = .zero
    public var multiplier: CGFloat = 1.0

    public init(item: Item<AnchorType>?) {
        self.item = item
    }

    public init(constant: AnchorType.ConstantType) {
        self.item = nil
        self.constant = constant
    }
}

public protocol ConstraintExpressionConvertible {
    associatedtype AnchorType: Anchor

    func toConstraintExpression() -> ConstraintExpression<AnchorType>
}

extension ConstraintExpression: ConstraintExpressionConvertible {
    public func toConstraintExpression() -> ConstraintExpression<AnchorType> {
        return self
    }
}

extension Item: ConstraintExpressionConvertible {
    public func toConstraintExpression() -> ConstraintExpression<AnchorType> {
        return ConstraintExpression(item: self)
    }
}

public func * <C: ConstraintExpressionConvertible>(lhs: C, rhs: CGFloat) -> ConstraintExpression<C.AnchorType> {
    var result = lhs.toConstraintExpression()
    result.multiplier = result.multiplier * rhs
    result.constant = result.constant * rhs
    return result
}

public func * <C: ConstraintExpressionConvertible>(lhs: CGFloat, rhs: C) -> ConstraintExpression<C.AnchorType> {
    return rhs * lhs
}

public func + <C: ConstraintExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.Value) -> ConstraintExpression<C.AnchorType> {
    var result = lhs.toConstraintExpression()
    result.constant = result.constant + rhs
    return result
}

public func + <C: ConstraintExpressionConvertible>(lhs: C.AnchorType.ConstantType.Value, rhs: C) -> ConstraintExpression<C.AnchorType> {
    return rhs + lhs
}

public func - <C: ConstraintExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.Value) -> ConstraintExpression<C.AnchorType> {
    var result = lhs.toConstraintExpression()
    result.constant = result.constant - rhs
    return result
}

public func - <C: ConstraintExpressionConvertible>(lhs: C.AnchorType.ConstantType.Value, rhs: C) -> ConstraintExpression<C.AnchorType> {
    var result = rhs.toConstraintExpression()
    result.constant = lhs - result.constant
    return result
}

public func == <C: ConstraintExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.Value) -> SingleConstraint<C.AnchorType> {
    let left = lhs.toConstraintExpression()
    let right = C.AnchorType.ConstantType(value: rhs)
    return SingleConstraint(left: left, relation: .equal, right: right)
}

public func == <C: ConstraintExpressionConvertible>(lhs: C.AnchorType.ConstantType.Value, rhs: C) -> SingleConstraint<C.AnchorType> {
    return rhs == lhs
}

public func >= <C: ConstraintExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.Value) -> SingleConstraint<C.AnchorType> {
    let left = lhs.toConstraintExpression()
    let right = C.AnchorType.ConstantType(value: rhs)
    return SingleConstraint(left: left, relation: .greaterThanOrEqual, right: right)
}

public func >= <C: ConstraintExpressionConvertible>(lhs: C.AnchorType.ConstantType.Value, rhs: C) -> SingleConstraint<C.AnchorType> {
    return rhs <= lhs
}

public func <= <C: ConstraintExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.Value) -> SingleConstraint<C.AnchorType> {
    let left = lhs.toConstraintExpression()
    let right = C.AnchorType.ConstantType(value: rhs)
    return SingleConstraint(left: left, relation: .lessThanOrEqual, right: right)
}

public func <= <C: ConstraintExpressionConvertible>(lhs: C.AnchorType.ConstantType.Value, rhs: C) -> SingleConstraint<C.AnchorType> {
    return rhs >= lhs
}

public func == <C1: ConstraintExpressionConvertible, C2: ConstraintExpressionConvertible>(lhs: C1, rhs: C2) -> SingleConstraint<C1.AnchorType> where C1.AnchorType == C2.AnchorType {
    let left = lhs.toConstraintExpression()
    let right = rhs.toConstraintExpression()
    return SingleConstraint(left: left, relation: .equal, right: right)
}

public func >= <C1: ConstraintExpressionConvertible, C2: ConstraintExpressionConvertible>(lhs: C1, rhs: C2) -> SingleConstraint<C1.AnchorType> where C1.AnchorType == C2.AnchorType {
    let left = lhs.toConstraintExpression()
    let right = rhs.toConstraintExpression()
    return SingleConstraint(left: left, relation: .greaterThanOrEqual, right: right)
}

public func <= <C1: ConstraintExpressionConvertible, C2: ConstraintExpressionConvertible>(lhs: C1, rhs: C2) -> SingleConstraint<C1.AnchorType> where C1.AnchorType == C2.AnchorType {
    let left = lhs.toConstraintExpression()
    let right = rhs.toConstraintExpression()
    return SingleConstraint(left: left, relation: .lessThanOrEqual, right: right)
}
