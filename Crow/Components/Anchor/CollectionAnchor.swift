import Foundation
import UIKit

public struct ListAnchor<AnchorType: SingleAnchor>: Anchor {
    public typealias ConstantType = AnchorType.ConstantType

    public let anchors: [AnchorType]

    public var description: String {
        return flatten().map { $0.description }.joined(separator: ".")
    }

    public init(anchors: [AnchorType]) {
        self.anchors = anchors
    }

    public func flatten() -> [SingleAnchorType] {
        return anchors.flatMap { $0.flatten() }
    }

    public static func + (lhs: ListAnchor, rhs: ListAnchor) -> ListAnchor {
        return ListAnchor(anchors: lhs.anchors + rhs.anchors)
    }

    public static func + (lhs: ListAnchor, rhs: AnchorType) -> ListAnchor {
        return ListAnchor(anchors: lhs.anchors + [rhs])
    }

    public static func + (lhs: AnchorType, rhs: ListAnchor) -> ListAnchor {
        return ListAnchor(anchors: [lhs] + rhs.anchors)
    }
}

extension ListAnchor: MultipliableAnchor where AnchorType: MultipliableAnchor {}

public struct PointAnchor<HorizontalAnchorType: SingleAnchor, VerticalAnchorType: SingleAnchor>: Anchor {
    public typealias ConstantType = PointConstant

    public let horizontal: ListAnchor<HorizontalAnchorType>
    public let vertical: ListAnchor<VerticalAnchorType>

    public var description: String {
        return flatten().map { $0.description }.joined(separator: ".")
    }

    public init(horizontal: HorizontalAnchorType, vertical: VerticalAnchorType) {
        self.horizontal = ListAnchor(anchors: [horizontal])
        self.vertical = ListAnchor(anchors: [vertical])
    }

    public init(horizontal: ListAnchor<HorizontalAnchorType>, vertical: ListAnchor<VerticalAnchorType>) {
        self.horizontal = horizontal
        self.vertical = vertical
    }

    public func flatten() -> [SingleAnchorType] {
        return horizontal.flatten() + vertical.flatten()
    }

    public static func + (lhs: PointAnchor, rhs: PointAnchor) -> PointAnchor {
        return PointAnchor(
            horizontal: lhs.horizontal + rhs.horizontal,
            vertical: lhs.vertical + rhs.vertical
        )
    }

    public static func + (lhs: PointAnchor, rhs: HorizontalAnchorType) -> PointAnchor {
        return PointAnchor(horizontal: lhs.horizontal + rhs, vertical: lhs.vertical)
    }

    public static func + (lhs: HorizontalAnchorType, rhs: PointAnchor) -> PointAnchor {
        return PointAnchor(horizontal: lhs + rhs.horizontal, vertical: rhs.vertical)
    }

    public static func + (lhs: PointAnchor, rhs: VerticalAnchorType) -> PointAnchor {
        return PointAnchor(horizontal: lhs.horizontal, vertical: lhs.vertical + rhs)
    }

    public static func + (lhs: VerticalAnchorType, rhs: PointAnchor) -> PointAnchor {
        return PointAnchor(horizontal: rhs.horizontal, vertical: lhs + rhs.vertical)
    }
}

extension PointAnchor: MultipliableAnchor
where HorizontalAnchorType: MultipliableAnchor, VerticalAnchorType: MultipliableAnchor {}
