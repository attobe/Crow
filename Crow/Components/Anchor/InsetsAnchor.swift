import Foundation
import UIKit

extension NSLayoutConstraint.Relation {
    fileprivate var conversed: NSLayoutConstraint.Relation {
        switch self {
        case .equal:
            return .equal
        case .greaterThanOrEqual:
            return .lessThanOrEqual
        case .lessThanOrEqual:
            return .greaterThanOrEqual
        }
    }
}

/// Represents east anchor.
public struct EastAnchor: SingleAnchor {
    public typealias ConstantType = InsetsConstant

    public static let instance = EastAnchor()

    public var description: String { return "east" }
    public var attribute: NSLayoutConstraint.Attribute { return .right }

    private init() {}

    public func extract(constant: InsetsConstant) -> CGFloat {
        return constant.value.right
    }
}

/// Represents west anchor.
public struct WestAnchor: SingleAnchor {
    public typealias ConstantType = InsetsConstant

    public static let instance = WestAnchor()

    public var description: String { return "west" }
    public var attribute: NSLayoutConstraint.Attribute { return .left }

    private init() {}

    public func transform(relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation {
        return relation.conversed
    }

    public func extract(constant: InsetsConstant) -> CGFloat {
        return -constant.value.left
    }
}

/// Represents north anchor.
public struct NorthAnchor: SingleAnchor {
    public typealias ConstantType = InsetsConstant

    public static let instance = NorthAnchor()

    public var description: String { return "north" }
    public var attribute: NSLayoutConstraint.Attribute { return .top }

    private init() {}

    public func transform(relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation {
        return relation.conversed
    }

    public func extract(constant: InsetsConstant) -> CGFloat {
        return -constant.value.top
    }
}

/// Represents south anchor.
public struct SouthAnchor: SingleAnchor {
    public typealias ConstantType = InsetsConstant

    public static let instance = SouthAnchor()

    public var description: String { return "south" }
    public var attribute: NSLayoutConstraint.Attribute { return .bottom }

    private init() {}

    public func extract(constant: InsetsConstant) -> CGFloat {
        return constant.value.bottom
    }
}
