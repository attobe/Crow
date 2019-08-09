import Foundation
import UIKit

public struct Expression<AnchorType: Anchor>: CustomStringConvertible {
    public let item: Item<AnchorType>?
    public var constant: AnchorType.ConstantType = .zero
    public var multiplier: CGFloat = 1.0

    public var description: String {
        let suffix = constant == .zero ? "" : " + \(constant)"
        if let item = item {
            if multiplier != 1.0 {
                return "\(multiplier) * \(item)\(suffix)"
            }
            return "\(item)\(suffix)"
        }
        return constant.description
    }

    public init(item: Item<AnchorType>?) {
        self.item = item
    }

    public init(constant: AnchorType.ConstantType) {
        self.item = nil
        self.constant = constant
    }
}

public protocol ExpressionConvertible {
    associatedtype AnchorType: Anchor

    func toExpression() -> Expression<AnchorType>
}

extension Expression: ExpressionConvertible {
    public func toExpression() -> Expression<AnchorType> {
        return self
    }
}

extension Item: ExpressionConvertible {
    public func toExpression() -> Expression<AnchorType> {
        return Expression(item: self)
    }
}

public protocol MultipliableExpressionConvertible {
    associatedtype AnchorType: Anchor

    func toMultipliableExpression() -> Expression<AnchorType>
}

extension Expression: MultipliableExpressionConvertible where AnchorType: MultipliableAnchor {
    public func toMultipliableExpression() -> Expression<AnchorType> {
        return self
    }
}

extension Item: MultipliableExpressionConvertible where AnchorType: MultipliableAnchor {
    public func toMultipliableExpression() -> Expression<AnchorType> {
        return Expression(item: self)
    }
}

public func * <C: MultipliableExpressionConvertible>(lhs: C, rhs: CGFloat) -> Expression<C.AnchorType> {
    var result = lhs.toMultipliableExpression()
    result.multiplier = result.multiplier * rhs
    result.constant = result.constant * rhs
    return result
}

public func * <C: MultipliableExpressionConvertible>(lhs: CGFloat, rhs: C) -> Expression<C.AnchorType> {
    return rhs * lhs
}

public func + <C: ExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.ConvertibleType) -> Expression<C.AnchorType> {
    var result = lhs.toExpression()
    result.constant = result.constant + C.AnchorType.ConstantType(rhs)
    return result
}

public func + <C: ExpressionConvertible>(lhs: C.AnchorType.ConstantType.ConvertibleType, rhs: C) -> Expression<C.AnchorType> {
    return rhs + lhs
}

public func - <C: ExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.ConvertibleType) -> Expression<C.AnchorType> {
    var result = lhs.toExpression()
    result.constant = result.constant - C.AnchorType.ConstantType(rhs)
    return result
}

public func - <C: MultipliableExpressionConvertible>(lhs: C.AnchorType.ConstantType.ConvertibleType, rhs: C) -> Expression<C.AnchorType> {
    return -1.0 * rhs + lhs
}

public func == <C: ExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.ConvertibleType) -> SingleConstraint<C.AnchorType> {
    let left = lhs.toExpression()
    let right = C.AnchorType.ConstantType(rhs)
    return SingleConstraint(left: left, relation: .equal, right: right)
}

public func == <C: ExpressionConvertible>(lhs: C.AnchorType.ConstantType.ConvertibleType, rhs: C) -> SingleConstraint<C.AnchorType> {
    return rhs == lhs
}

public func >= <C: ExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.ConvertibleType) -> SingleConstraint<C.AnchorType> {
    let left = lhs.toExpression()
    let right = C.AnchorType.ConstantType(rhs)
    return SingleConstraint(left: left, relation: .greaterThanOrEqual, right: right)
}

public func >= <C: ExpressionConvertible>(lhs: C.AnchorType.ConstantType.ConvertibleType, rhs: C) -> SingleConstraint<C.AnchorType> {
    return rhs <= lhs
}

public func <= <C: ExpressionConvertible>(lhs: C, rhs: C.AnchorType.ConstantType.ConvertibleType) -> SingleConstraint<C.AnchorType> {
    let left = lhs.toExpression()
    let right = C.AnchorType.ConstantType(rhs)
    return SingleConstraint(left: left, relation: .lessThanOrEqual, right: right)
}

public func <= <C: ExpressionConvertible>(lhs: C.AnchorType.ConstantType.ConvertibleType, rhs: C) -> SingleConstraint<C.AnchorType> {
    return rhs >= lhs
}

public func == <C1: ExpressionConvertible, C2: ExpressionConvertible>(lhs: C1, rhs: C2) -> SingleConstraint<C1.AnchorType> where C1.AnchorType == C2.AnchorType {
    let left = lhs.toExpression()
    let right = rhs.toExpression()
    return SingleConstraint(left: left, relation: .equal, right: right)
}

public func >= <C1: ExpressionConvertible, C2: ExpressionConvertible>(lhs: C1, rhs: C2) -> SingleConstraint<C1.AnchorType> where C1.AnchorType == C2.AnchorType {
    let left = lhs.toExpression()
    let right = rhs.toExpression()
    return SingleConstraint(left: left, relation: .greaterThanOrEqual, right: right)
}

public func <= <C1: ExpressionConvertible, C2: ExpressionConvertible>(lhs: C1, rhs: C2) -> SingleConstraint<C1.AnchorType> where C1.AnchorType == C2.AnchorType {
    let left = lhs.toExpression()
    let right = rhs.toExpression()
    return SingleConstraint(left: left, relation: .lessThanOrEqual, right: right)
}
