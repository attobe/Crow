import Foundation
import UIKit

public protocol Anchor {
    associatedtype ConstantType: Constant

    var attributes: [NSLayoutConstraint.Attribute] { get }

    func expand(constant: ConstantType) -> [AttributedConstant]
}

extension Anchor where ConstantType == FloatConstant {
    public func expand(constant: ConstantType) -> [AttributedConstant] {
        return attributes.map { AttributedConstant(attribute: $0, constant: constant.value) }
    }
}

/// Represents vertical anchor, such as top, bottom, centerX.
public struct HorizontalAnchor: Anchor {
    public typealias ConstantType = FloatConstant

    public static let left = HorizontalAnchor(attributes: [.left])
    public static let right = HorizontalAnchor(attributes: [.right])

    public static let leading = HorizontalAnchor(attributes: [.leading])
    public static let trailing = HorizontalAnchor(attributes: [.trailing])

    public static let centerX = HorizontalAnchor(attributes: [.centerX])

    public let attributes: [NSLayoutConstraint.Attribute]

    private init(attributes: [NSLayoutConstraint.Attribute]) {
        self.attributes = attributes
    }

    public static func + (lhs: HorizontalAnchor, rhs: HorizontalAnchor) -> HorizontalAnchor {
        return HorizontalAnchor(attributes: lhs.attributes + rhs.attributes)
    }

    public static func + (lhs: HorizontalAnchor, rhs: VerticalAnchor) -> PositionAnchor {
        return PositionAnchor(horizontal: lhs, vertical: rhs)
    }

    public static func + (lhs: HorizontalAnchor, rhs: PositionAnchor) -> PositionAnchor {
        return PositionAnchor(horizontal: lhs + rhs.horizontal, vertical: rhs.vertical)
    }
}

/// Represents vertical anchor, such as left, right, centerY.
public struct VerticalAnchor: Anchor {
    public typealias ConstantType = FloatConstant

    public static let top = VerticalAnchor(attributes: [.top])
    public static let bottom = VerticalAnchor(attributes: [.bottom])

    public static let centerY = VerticalAnchor(attributes: [.centerY])

    public static let firstBaseline = VerticalAnchor(attributes: [.firstBaseline])
    public static let lastBaseline = VerticalAnchor(attributes: [.lastBaseline])

    public let attributes: [NSLayoutConstraint.Attribute]

    private init(attributes: [NSLayoutConstraint.Attribute]) {
        self.attributes = attributes
    }

    public static func + (lhs: VerticalAnchor, rhs: VerticalAnchor) -> VerticalAnchor {
        return VerticalAnchor(attributes: lhs.attributes + rhs.attributes)
    }

    public static func + (lhs: VerticalAnchor, rhs: HorizontalAnchor) -> PositionAnchor {
        return PositionAnchor(horizontal: rhs, vertical: lhs)
    }

    public static func + (lhs: VerticalAnchor, rhs: PositionAnchor) -> PositionAnchor {
        return PositionAnchor(horizontal: rhs.horizontal, vertical: lhs + rhs.vertical)
    }
}

/// Represents vertical and horizontal anchors.
public struct PositionAnchor: Anchor {
    public typealias ConstantType = PointConstant

    public static let center = PositionAnchor(horizontal: .centerX, vertical: .centerY)

    public let horizontal: HorizontalAnchor
    public let vertical: VerticalAnchor

    public var attributes: [NSLayoutConstraint.Attribute] {
        return horizontal.attributes + vertical.attributes
    }

    fileprivate init(horizontal: HorizontalAnchor, vertical: VerticalAnchor) {
        self.horizontal = horizontal
        self.vertical = vertical
    }

    public static func + (lhs: PositionAnchor, rhs: PositionAnchor) -> PositionAnchor {
        return PositionAnchor(horizontal: lhs.horizontal + rhs.horizontal, vertical: lhs.vertical + rhs.vertical)
    }

    public static func + (lhs: PositionAnchor, rhs: HorizontalAnchor) -> PositionAnchor {
        return PositionAnchor(horizontal: lhs.horizontal + rhs, vertical: lhs.vertical)
    }

    public static func + (lhs: PositionAnchor, rhs: VerticalAnchor) -> PositionAnchor {
        return PositionAnchor(horizontal: lhs.horizontal, vertical: lhs.vertical + rhs)
    }

    public func expand(constant: ConstantType) -> [AttributedConstant] {
        return horizontal.expand(constant: FloatConstant(value: constant.value.x))
            + vertical.expand(constant: FloatConstant(value: constant.value.y))
    }
}

public struct WidthAnchor: Anchor {
    public typealias ConstantType = FloatConstant

    public static let instance = WidthAnchor()

    public var attributes: [NSLayoutConstraint.Attribute] {
        return [.width]
    }

    private init() {}
}

public struct HeightAnchor: Anchor {
    public typealias ConstantType = FloatConstant

    public static let instance = HeightAnchor()

    public var attributes: [NSLayoutConstraint.Attribute] {
        return [.height]
    }

    private init() {}
}

public struct SizeAnchor: Anchor {
    public typealias ConstantType = SizeConstant

    public static let instance = SizeAnchor()

    public var attributes: [NSLayoutConstraint.Attribute] {
        return [.width, .height]
    }

    private init() {}

    public func expand(constant: SizeConstant) -> [AttributedConstant] {
        return [
            AttributedConstant(attribute: .width, constant: constant.value.width),
            AttributedConstant(attribute: .height, constant: constant.value.height)
        ]
    }
}

public struct EdgeAnchor: Anchor {
    public typealias ConstantType = InsetsConstant

    public static let instance = EdgeAnchor()

    public var attributes: [NSLayoutConstraint.Attribute] {
        return [.top, .left, .bottom, .right]
    }

    private init() {}

    public func expand(constant: InsetsConstant) -> [AttributedConstant] {
        return [
            AttributedConstant(attribute: .top, constant: constant.value.top),
            AttributedConstant(attribute: .left, constant: constant.value.left),
            AttributedConstant(attribute: .bottom, constant: constant.value.bottom),
            AttributedConstant(attribute: .right, constant: constant.value.right)
        ]
    }
}
