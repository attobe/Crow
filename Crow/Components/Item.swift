import Foundation
import UIKit

public struct Item<AnchorType: Anchor>: CustomStringConvertible {
    public var view: AnyObject
    public var anchor: AnchorType

    public var description: String {
        let hash = UInt(bitPattern: ObjectIdentifier(view))
        let clazz = String(describing: type(of: view))
        let object = String(hash, radix: 16, uppercase: true)
        return clazz + "[" + object + "]." + anchor.description
    }

    public init(view: AnyObject, anchor: AnchorType) {
        self.view = view
        self.anchor = anchor
    }
}

extension Item where AnchorType == HorizontalAnchor {
    public var left: Item<ListAnchor<HorizontalAnchor>> {
        return Item<ListAnchor<HorizontalAnchor>>(view: view, anchor: anchor + HorizontalAnchor.left)
    }

    public var leading: Item<ListAnchor<HorizontalAnchor>> {
        return Item<ListAnchor<HorizontalAnchor>>(view: view, anchor: anchor + HorizontalAnchor.leading)
    }

    public var right: Item<ListAnchor<HorizontalAnchor>> {
        return Item<ListAnchor<HorizontalAnchor>>(view: view, anchor: anchor + HorizontalAnchor.right)
    }

    public var trailing: Item<ListAnchor<HorizontalAnchor>> {
        return Item<ListAnchor<HorizontalAnchor>>(view: view, anchor: anchor + HorizontalAnchor.trailing)
    }

    public var centerX: Item<ListAnchor<HorizontalAnchor>> {
        return Item<ListAnchor<HorizontalAnchor>>(view: view, anchor: anchor + HorizontalAnchor.centerX)
    }

    public var top: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + VerticalAnchor.top)
    }

    public var bottom: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + VerticalAnchor.bottom)
    }

    public var centerY: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + VerticalAnchor.centerY)
    }

    public var firstBaseline: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + VerticalAnchor.firstBaseline)
    }

    public var lastBaseline: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + VerticalAnchor.lastBaseline)
    }
}

extension Item where AnchorType == VerticalAnchor {
    public var top: Item<ListAnchor<VerticalAnchor>> {
        return Item<ListAnchor<VerticalAnchor>>(view: view, anchor: anchor + VerticalAnchor.top)
    }

    public var bottom: Item<ListAnchor<VerticalAnchor>> {
        return Item<ListAnchor<VerticalAnchor>>(view: view, anchor: anchor + VerticalAnchor.bottom)
    }

    public var centerY: Item<ListAnchor<VerticalAnchor>> {
        return Item<ListAnchor<VerticalAnchor>>(view: view, anchor: anchor + VerticalAnchor.centerY)
    }

    public var firstBaseline: Item<ListAnchor<VerticalAnchor>> {
        return Item<ListAnchor<VerticalAnchor>>(view: view, anchor: anchor + VerticalAnchor.firstBaseline)
    }

    public var lastBaseline: Item<ListAnchor<VerticalAnchor>> {
        return Item<ListAnchor<VerticalAnchor>>(view: view, anchor: anchor + VerticalAnchor.lastBaseline)
    }

    public var left: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + HorizontalAnchor.left)
    }

    public var leading: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + HorizontalAnchor.leading)
    }

    public var right: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + HorizontalAnchor.right)
    }

    public var trailing: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + HorizontalAnchor.trailing)
    }

    public var centerX: Item<PositionalAnchor> {
        return Item<PositionalAnchor>(view: view, anchor: anchor + HorizontalAnchor.centerX)
    }
}

extension Item where AnchorType == PositionalAnchor {
    public var left: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.left)
    }

    public var leading: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.leading)
    }

    public var right: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.right)
    }

    public var trailing: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.trailing)
    }

    public var centerX: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.centerX)
    }

    public var top: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.top)
    }

    public var bottom: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.bottom)
    }

    public var centerY: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.centerY)
    }

    public var firstBaseline: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.firstBaseline)
    }

    public var lastBaseline: Item<PositionalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.lastBaseline)
    }
}

extension Item where AnchorType: DirectionAnchor {
    public var north: Item<EdgeAnchor> {
        return Item<EdgeAnchor>(view: view, anchor: anchor + EdgeAnchor.north)
    }

    public var south: Item<EdgeAnchor> {
        return Item<EdgeAnchor>(view: view, anchor: anchor + EdgeAnchor.south)
    }

    public var east: Item<EdgeAnchor> {
        return Item<EdgeAnchor>(view: view, anchor: anchor + EdgeAnchor.east)
    }

    public var west: Item<EdgeAnchor> {
        return Item<EdgeAnchor>(view: view, anchor: anchor + EdgeAnchor.west)
    }
}
