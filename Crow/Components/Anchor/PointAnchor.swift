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
}
