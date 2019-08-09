import Foundation
import UIKit

extension NSLayoutConstraint.Relation {
    fileprivate var reversed: NSLayoutConstraint.Relation {
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

public protocol DirectionAnchor: Anchor {
    func toEdgeAnchor() -> EdgeAnchor
}

public protocol SingleDirectionAnchor: DirectionAnchor, SingleAnchor {}

/// Represents east anchor.
public struct EastAnchor: SingleDirectionAnchor {
    public typealias ConstantType = InsetsConstant

    public static let instance = EastAnchor()

    public var description: String { return "east" }
    public var attribute: NSLayoutConstraint.Attribute { return .right }

    private init() {}

    public func extract(constant: InsetsConstant) -> CGFloat {
        return constant.value.right
    }

    public func toEdgeAnchor() -> EdgeAnchor {
        return .east
    }
}

/// Represents west anchor.
public struct WestAnchor: SingleDirectionAnchor {
    public typealias ConstantType = InsetsConstant

    public static let instance = WestAnchor()

    public var description: String { return "west" }
    public var attribute: NSLayoutConstraint.Attribute { return .left }

    private init() {}

    public func transform(relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation {
        return relation.reversed
    }

    public func extract(constant: InsetsConstant) -> CGFloat {
        return -constant.value.left
    }

    public func toEdgeAnchor() -> EdgeAnchor {
        return .west
    }
}

/// Represents north anchor.
public struct NorthAnchor: SingleDirectionAnchor {
    public typealias ConstantType = InsetsConstant

    public static let instance = NorthAnchor()

    public var description: String { return "north" }
    public var attribute: NSLayoutConstraint.Attribute { return .top }

    private init() {}

    public func transform(relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation {
        return relation.reversed
    }

    public func extract(constant: InsetsConstant) -> CGFloat {
        return -constant.value.top
    }

    public func toEdgeAnchor() -> EdgeAnchor {
        return .north
    }
}

/// Represents south anchor.
public struct SouthAnchor: SingleDirectionAnchor {
    public typealias ConstantType = InsetsConstant

    public static let instance = SouthAnchor()

    public var description: String { return "south" }
    public var attribute: NSLayoutConstraint.Attribute { return .bottom }

    private init() {}

    public func extract(constant: InsetsConstant) -> CGFloat {
        return constant.value.bottom
    }

    public func toEdgeAnchor() -> EdgeAnchor {
        return .south
    }
}

/// Represents vertical and horizontal direction anchors.
public struct EdgeAnchor: OptionSet, DirectionAnchor {
    public typealias ConstantType = InsetsConstant

    public let rawValue: UInt

    public static let north = EdgeAnchor(rawValue: 1 << 0)
    public static let south = EdgeAnchor(rawValue: 1 << 1)
    public static let east = EdgeAnchor(rawValue: 1 << 2)
    public static let west = EdgeAnchor(rawValue: 1 << 3)
    public static let edge: EdgeAnchor = [north, south, east, west]

    public var description: String {
        if self == EdgeAnchor.edge {
            return "edge"
        }
        return flatten().map { $0.description }.joined(separator: ".")
    }

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    public func flatten() -> [SingleAnchorType] {
        var anchors: [SingleAnchorType] = []
        if contains(.north) {
            anchors.append(NorthAnchor.instance)
        }

        if contains(.south) {
            anchors.append(SouthAnchor.instance)
        }

        if contains(.east) {
            anchors.append(EastAnchor.instance)
        }

        if contains(.west) {
            anchors.append(WestAnchor.instance)
        }
        return anchors
    }

    public func toEdgeAnchor() -> EdgeAnchor {
        return self
    }
}

public func + <LeftAnchor: DirectionAnchor, RightAnchor: DirectionAnchor>(lhs: LeftAnchor, rhs: RightAnchor) -> EdgeAnchor {
    return [lhs.toEdgeAnchor(), rhs.toEdgeAnchor()]
}

// MARK: Anchor holders

public protocol EdgeAnchorHolder: AnchorHolder {}

extension EdgeAnchorHolder {
    public var east: Item<EastAnchor> {
        return Item(view: view, anchor: .instance)
    }

    public var west: Item<WestAnchor> {
        return Item(view: view, anchor: .instance)
    }

    public var north: Item<NorthAnchor> {
        return Item(view: view, anchor: .instance)
    }

    public var south: Item<SouthAnchor> {
        return Item(view: view, anchor: .instance)
    }

    public var edge: Item<EdgeAnchor> {
        return Item(view: view, anchor: .edge)
    }
}
