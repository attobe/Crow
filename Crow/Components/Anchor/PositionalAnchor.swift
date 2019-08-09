import Foundation
import UIKit

/// Represents vertical anchor, such as top, bottom, centerX.
public enum HorizontalAnchor: SingleAnchor, MultipliableAnchor {
    public typealias ConstantType = PointConstant

    case left
    case right
    case leading
    case trailing
    case centerX

    public var description: String {
        switch self {
        case .left: return "left"
        case .right: return "right"
        case .leading: return "leading"
        case .trailing: return "trailing"
        case .centerX: return "centerX"
        }
    }

    public var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .left: return .left
        case .right: return .right
        case .leading: return .leading
        case .trailing: return .trailing
        case .centerX: return .centerX
        }
    }

    public func extract(constant: PointConstant) -> CGFloat {
        return constant.value.x
    }

    public static func + (lhs: HorizontalAnchor, rhs: HorizontalAnchor) -> ListAnchor<HorizontalAnchor> {
        return ListAnchor(anchors: [lhs, rhs])
    }

    public static func + (lhs: HorizontalAnchor, rhs: VerticalAnchor) -> PointAnchor<HorizontalAnchor, VerticalAnchor> {
        return PointAnchor<HorizontalAnchor, VerticalAnchor>(horizontal: lhs, vertical: rhs)
    }
}

/// Represents vertical anchor, such as left, right, centerY.
public enum VerticalAnchor: SingleAnchor, MultipliableAnchor {
    public typealias ConstantType = PointConstant

    case top
    case bottom
    case centerY
    case firstBaseline
    case lastBaseline

    public var description: String {
        switch self {
        case .top: return "top"
        case .bottom: return "bottom"
        case .centerY: return "centerY"
        case .firstBaseline: return "firstBaseline"
        case .lastBaseline: return "lastBaseline"
        }
    }

    public var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        case .centerY: return .centerY
        case .firstBaseline: return .firstBaseline
        case .lastBaseline: return .lastBaseline
        }
    }

    public func extract(constant: PointConstant) -> CGFloat {
        return constant.value.y
    }

    public static func + (lhs: VerticalAnchor, rhs: VerticalAnchor) -> ListAnchor<VerticalAnchor> {
        return ListAnchor(anchors: [lhs, rhs])
    }

    public static func + (lhs: VerticalAnchor, rhs: HorizontalAnchor) -> PointAnchor<HorizontalAnchor, VerticalAnchor> {
        return PointAnchor<HorizontalAnchor, VerticalAnchor>(horizontal: rhs, vertical: lhs)
    }
}

/// Represents vertical and horizontal anchors.
public typealias PositionalAnchor = PointAnchor<HorizontalAnchor, VerticalAnchor>

// MARK: Anchor holders

public protocol HorizontalAnchorHolder: AnchorHolder {}

extension HorizontalAnchorHolder {
    public var left: Item<HorizontalAnchor> {
        return Item(view: view, anchor: .left)
    }

    public var leading: Item<HorizontalAnchor> {
        return Item(view: view, anchor: .leading)
    }

    public var right: Item<HorizontalAnchor> {
        return Item(view: view, anchor: .right)
    }

    public var trailing: Item<HorizontalAnchor> {
        return Item(view: view, anchor: .trailing)
    }

    public var centerX: Item<HorizontalAnchor> {
        return Item(view: view, anchor: .centerX)
    }
}

public protocol VerticalAnchorHolder: AnchorHolder {}

extension VerticalAnchorHolder {
    public var top: Item<VerticalAnchor> {
        return Item(view: view, anchor: .top)
    }

    public var bottom: Item<VerticalAnchor> {
        return Item(view: view, anchor: .bottom)
    }

    public var centerY: Item<VerticalAnchor> {
        return Item(view: view, anchor: .centerY)
    }

    public var firstBaseline: Item<VerticalAnchor> {
        return Item(view: view, anchor: .firstBaseline)
    }

    public var lastBaseline: Item<VerticalAnchor> {
        return Item(view: view, anchor: .lastBaseline)
    }
}

public protocol PositionalAnchorHolder: AnchorHolder {}

extension PositionalAnchorHolder {
    public var center: Item<PositionalAnchor> {
        return Item(view: view, anchor: PositionalAnchor(horizontal: .centerX, vertical: .centerY))
    }
}
