import Foundation
import UIKit

public protocol Constant {
    associatedtype Value

    init(value: Value)

    static var zero: Self { get }

    static prefix func - (operand: Self) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: CGFloat) -> Self
}

extension Constant {
    public static func + (lhs: Self, rhs: Value) -> Self {
        return lhs + Self(value: rhs)
    }

    public static func + (lhs: Value, rhs: Self) -> Self {
        return Self(value: lhs) - rhs
    }

    public static func - (lhs: Self, rhs: Value) -> Self {
        return lhs - Self(value: rhs)
    }

    public static func - (lhs: Value, rhs: Self) -> Self {
        return Self(value: lhs) - rhs
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        return lhs + (-rhs)
    }

    public static func * (lhs: CGFloat, rhs: Self) -> Self {
        return rhs * lhs
    }
}

public struct FloatConstant: Constant {
    public let value: CGFloat

    public init(value: CGFloat) {
        self.value = value
    }

    public static let zero = FloatConstant(value: 0.0)

    public static prefix func - (operand: FloatConstant) -> FloatConstant {
        return FloatConstant(value: -operand.value)
    }

    public static func + (lhs: FloatConstant, rhs: FloatConstant) -> FloatConstant {
        return FloatConstant(value: lhs.value + rhs.value)
    }

    public static func * (lhs: FloatConstant, rhs: CGFloat) -> FloatConstant {
        return FloatConstant(value: lhs.value * rhs)
    }
}

public struct PointConstant: Constant {
    public let value: CGPoint

    public init(value: CGPoint) {
        self.value = value
    }

    public static let zero = PointConstant(value: .zero)

    public static prefix func - (operand: PointConstant) -> PointConstant {
        return PointConstant(value: CGPoint(x: -operand.value.x, y: -operand.value.y))
    }

    public static func + (lhs: PointConstant, rhs: PointConstant) -> PointConstant {
        return PointConstant(value: CGPoint(x: lhs.value.x + rhs.value.x, y: lhs.value.y + rhs.value.y))
    }

    public static func * (lhs: PointConstant, rhs: CGFloat) -> PointConstant {
        return PointConstant(value: CGPoint(x: lhs.value.x * rhs, y: lhs.value.y * rhs))
    }
}

public struct SizeConstant: Constant {
    public let value: CGSize

    public init(value: CGSize) {
        self.value = value
    }

    public static let zero = SizeConstant(value: .zero)

    public static prefix func - (operand: SizeConstant) -> SizeConstant {
        return SizeConstant(value: CGSize(width: -operand.value.width, height: -operand.value.height))
    }

    public static func + (lhs: SizeConstant, rhs: SizeConstant) -> SizeConstant {
        return SizeConstant(value: CGSize(width: lhs.value.width + rhs.value.width, height: lhs.value.height + rhs.value.height))
    }

    public static func * (lhs: SizeConstant, rhs: CGFloat) -> SizeConstant {
        return SizeConstant(value: CGSize(width: lhs.value.width * rhs, height: lhs.value.height * rhs))
    }
}

public struct InsetsConstant: Constant {
    public let value: UIEdgeInsets

    public init(value: UIEdgeInsets) {
        self.value = value
    }

    public static let zero = InsetsConstant(value: .zero)

    public static prefix func - (operand: InsetsConstant) -> InsetsConstant {
        return InsetsConstant(value: UIEdgeInsets(top: -operand.value.top,
                                                  left: -operand.value.left,
                                                  bottom: -operand.value.bottom,
                                                  right: -operand.value.right))
    }

    public static func + (lhs: InsetsConstant, rhs: InsetsConstant) -> InsetsConstant {
        return InsetsConstant(value: UIEdgeInsets(top: lhs.value.top + rhs.value.top,
                                                  left: lhs.value.left + rhs.value.left,
                                                  bottom: lhs.value.bottom + rhs.value.bottom,
                                                  right: lhs.value.right + rhs.value.right))
    }

    public static func * (lhs: InsetsConstant, rhs: CGFloat) -> InsetsConstant {
        return InsetsConstant(value: UIEdgeInsets(top: lhs.value.top * rhs,
                                                  left: lhs.value.left * rhs,
                                                  bottom: lhs.value.bottom * rhs,
                                                  right: lhs.value.right * rhs))
    }
}
