import Foundation
import UIKit

public struct Item<AnchorType: Anchor> {
    public var view: Any
    public var anchor: AnchorType

    public init(view: Any, anchor: AnchorType) {
        self.view = view
        self.anchor = anchor
    }
}

extension Item where AnchorType == HorizontalAnchor {
    public var left: Item<HorizontalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.left)
    }

    public var leading: Item<HorizontalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.leading)
    }

    public var right: Item<HorizontalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.right)
    }

    public var trailing: Item<HorizontalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.trailing)
    }

    public var centerX: Item<HorizontalAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.centerX)
    }

    public var top: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + VerticalAnchor.top)
    }

    public var bottom: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + VerticalAnchor.bottom)
    }

    public var centerY: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + VerticalAnchor.centerY)
    }

    public var firstBaseline: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + VerticalAnchor.firstBaseline)
    }

    public var lastBaseline: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + VerticalAnchor.lastBaseline)
    }
}

extension Item where AnchorType == VerticalAnchor {
    public var top: Item<VerticalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.top)
    }

    public var bottom: Item<VerticalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.bottom)
    }

    public var centerY: Item<VerticalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.centerY)
    }

    public var firstBaseline: Item<VerticalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.firstBaseline)
    }

    public var lastBaseline: Item<VerticalAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.lastBaseline)
    }

    public var left: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + HorizontalAnchor.left)
    }

    public var leading: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + HorizontalAnchor.leading)
    }

    public var right: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + HorizontalAnchor.right)
    }

    public var trailing: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + HorizontalAnchor.trailing)
    }

    public var centerX: Item<PositionAnchor> {
        return Item<PositionAnchor>(view: view, anchor: anchor + HorizontalAnchor.centerX)
    }
}

extension Item where AnchorType == PositionAnchor {
    public var left: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.left)
    }

    public var leading: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.leading)
    }

    public var right: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.right)
    }

    public var trailing: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.trailing)
    }

    public var centerX: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + HorizontalAnchor.centerX)
    }

    public var top: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.top)
    }

    public var bottom: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.bottom)
    }

    public var centerY: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.centerY)
    }

    public var firstBaseline: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.firstBaseline)
    }

    public var lastBaseline: Item<PositionAnchor> {
        return Item(view: view, anchor: anchor + VerticalAnchor.lastBaseline)
    }
}
