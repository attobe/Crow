import Foundation
import UIKit

public protocol AnchorHolder {
    var view: AnyObject { get }
}

// MARK: Point Anchors

extension AnchorHolder {
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

    public var center: Item<PairAnchor<HorizontalAnchor, VerticalAnchor>> {
        return Item(view: view, anchor: PairAnchor(first: .centerX, second: .centerY, name: "center"))
    }
}

// MARK: Size Anchors

extension AnchorHolder {
    public var width: Item<LengthAnchor> {
        return Item(view: view, anchor: .width)
    }

    public var height: Item<LengthAnchor> {
        return Item(view: view, anchor: .height)
    }

    public var size: Item<PairAnchor<LengthAnchor, LengthAnchor>> {
        return Item(view: view, anchor: PairAnchor(first: .width, second: .height, name: "size"))
    }
}

// MARK: Insets Anchors

extension AnchorHolder {
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

    public var edge: Item<PairAnchor<EastAnchor, PairAnchor<WestAnchor, PairAnchor<NorthAnchor, SouthAnchor>>>> {
        return Item(
            view: view,
            anchor: PairAnchor(
                first: .instance,
                second: PairAnchor(
                    first: .instance,
                    second: PairAnchor(first: .instance, second: .instance)
                ),
                name: "edge"
            )
        )
    }
}
