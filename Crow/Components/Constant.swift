import Foundation
import UIKit

public protocol Constant: CustomStringConvertible {
    associatedtype ConvertibleType

    init(_ value: ConvertibleType)

    static var zero: Self { get }

    static prefix func - (operand: Self) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: CGFloat) -> Self
    static func == (lhs: Self, rhs: Self) -> Bool
}

extension Constant {
    public static func + (lhs: Self, rhs: ConvertibleType) -> Self {
        return lhs + Self(rhs)
    }

    public static func + (lhs: ConvertibleType, rhs: Self) -> Self {
        return Self(lhs) - rhs
    }

    public static func - (lhs: Self, rhs: ConvertibleType) -> Self {
        return lhs - Self(rhs)
    }

    public static func - (lhs: ConvertibleType, rhs: Self) -> Self {
        return Self(lhs) - rhs
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        return lhs + (-rhs)
    }

    public static func * (lhs: CGFloat, rhs: Self) -> Self {
        return rhs * lhs
    }

    public static func != (lhs: Self, rhs: Self) -> Bool {
        return !(lhs == rhs)
    }
}

public struct PointConstant: Constant {
    public let value: CGPoint

    public var description: String {
        if value.x == value.y {
            return value.x.description
        }
        return value.debugDescription
    }

    public init(_ value: PointConvertible) {
        self.value = value.toPoint()
    }

    public static let zero = PointConstant(CGPoint.zero)

    public static prefix func - (operand: PointConstant) -> PointConstant {
        return PointConstant(CGPoint(x: -operand.value.x, y: -operand.value.y))
    }

    public static func + (lhs: PointConstant, rhs: PointConstant) -> PointConstant {
        return PointConstant(CGPoint(x: lhs.value.x + rhs.value.x, y: lhs.value.y + rhs.value.y))
    }

    public static func * (lhs: PointConstant, rhs: CGFloat) -> PointConstant {
        return PointConstant(CGPoint(x: lhs.value.x * rhs, y: lhs.value.y * rhs))
    }

    public static func == (lhs: PointConstant, rhs: PointConstant) -> Bool {
        return lhs.value == rhs.value
    }
}

public struct SizeConstant: Constant {
    public let value: CGSize

    public var description: String {
        if value.width == value.height {
            return value.width.description
        }
        return value.debugDescription
    }

    public init(_ value: SizeConvertible) {
        self.value = value.toSize()
    }

    public static let zero = SizeConstant(CGSize.zero)

    public static prefix func - (operand: SizeConstant) -> SizeConstant {
        return SizeConstant(CGSize(width: -operand.value.width, height: -operand.value.height))
    }

    public static func + (lhs: SizeConstant, rhs: SizeConstant) -> SizeConstant {
        return SizeConstant(CGSize(width: lhs.value.width + rhs.value.width, height: lhs.value.height + rhs.value.height))
    }

    public static func * (lhs: SizeConstant, rhs: CGFloat) -> SizeConstant {
        return SizeConstant(CGSize(width: lhs.value.width * rhs, height: lhs.value.height * rhs))
    }

    public static func == (lhs: SizeConstant, rhs: SizeConstant) -> Bool {
        return lhs.value == rhs.value
    }
}

public struct InsetsConstant: Constant {
    public let value: UIEdgeInsets

    public var description: String {
        if value.top == value.bottom && value.left == value.right {
            if value.top == value.left {
                return value.top.description
            }
            return "(" + value.left.description + ", " + value.top.description + ")"
        }
        return "(east: " + value.right.description
            + ", west: " + value.left.description
            + ", north: " + value.top.description
            + ", south: " + value.bottom.description
            + ")"
    }

    public init(_ value: InsetsConvertible) {
        self.value = value.toInsets()
    }

    public static let zero = InsetsConstant(UIEdgeInsets.zero)

    public static prefix func - (operand: InsetsConstant) -> InsetsConstant {
        return InsetsConstant(UIEdgeInsets(top: -operand.value.top,
                                           left: -operand.value.left,
                                           bottom: -operand.value.bottom,
                                           right: -operand.value.right))
    }

    public static func + (lhs: InsetsConstant, rhs: InsetsConstant) -> InsetsConstant {
        return InsetsConstant(UIEdgeInsets(top: lhs.value.top + rhs.value.top,
                                           left: lhs.value.left + rhs.value.left,
                                           bottom: lhs.value.bottom + rhs.value.bottom,
                                           right: lhs.value.right + rhs.value.right))
    }

    public static func * (lhs: InsetsConstant, rhs: CGFloat) -> InsetsConstant {
        return InsetsConstant(UIEdgeInsets(top: lhs.value.top * rhs,
                                           left: lhs.value.left * rhs,
                                           bottom: lhs.value.bottom * rhs,
                                           right: lhs.value.right * rhs))
    }

    public static func == (lhs: InsetsConstant, rhs: InsetsConstant) -> Bool {
        return lhs.value == rhs.value
    }
}
