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

extension Item where AnchorType.ConstantType == PointConstant {
    public var top: Item<PairAnchor<AnchorType, VerticalAnchor>> {
        return Item<PairAnchor<AnchorType, VerticalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .top)
        )
    }

    public var bottom: Item<PairAnchor<AnchorType, VerticalAnchor>> {
        return Item<PairAnchor<AnchorType, VerticalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .bottom)
        )
    }

    public var centerY: Item<PairAnchor<AnchorType, VerticalAnchor>> {
        return Item<PairAnchor<AnchorType, VerticalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .centerY)
        )
    }

    public var firstBaseline: Item<PairAnchor<AnchorType, VerticalAnchor>> {
        return Item<PairAnchor<AnchorType, VerticalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .firstBaseline)
        )
    }

    public var lastBaseline: Item<PairAnchor<AnchorType, VerticalAnchor>> {
        return Item<PairAnchor<AnchorType, VerticalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .lastBaseline)
        )
    }

    public var left: Item<PairAnchor<AnchorType, HorizontalAnchor>> {
        return Item<PairAnchor<AnchorType, HorizontalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .left)
        )
    }

    public var leading: Item<PairAnchor<AnchorType, HorizontalAnchor>> {
        return Item<PairAnchor<AnchorType, HorizontalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .leading)
        )
    }

    public var right: Item<PairAnchor<AnchorType, HorizontalAnchor>> {
        return Item<PairAnchor<AnchorType, HorizontalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .right)
        )
    }

    public var trailing: Item<PairAnchor<AnchorType, HorizontalAnchor>> {
        return Item<PairAnchor<AnchorType, HorizontalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .trailing)
        )
    }

    public var centerX: Item<PairAnchor<AnchorType, HorizontalAnchor>> {
        return Item<PairAnchor<AnchorType, HorizontalAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .centerX)
        )
    }
}

extension Item where AnchorType.ConstantType == SizeConstant {
    public var width: Item<PairAnchor<AnchorType, LengthAnchor>> {
        return Item<PairAnchor<AnchorType, LengthAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .width)
        )
    }

    public var height: Item<PairAnchor<AnchorType, LengthAnchor>> {
        return Item<PairAnchor<AnchorType, LengthAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .height)
        )
    }
}

extension Item where AnchorType.ConstantType == InsetsConstant {
    public var east: Item<PairAnchor<AnchorType, EastAnchor>> {
        return Item<PairAnchor<AnchorType, EastAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .instance)
        )
    }

    public var west: Item<PairAnchor<AnchorType, WestAnchor>> {
        return Item<PairAnchor<AnchorType, WestAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .instance)
        )
    }

    public var north: Item<PairAnchor<AnchorType, NorthAnchor>> {
        return Item<PairAnchor<AnchorType, NorthAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .instance)
        )
    }

    public var south: Item<PairAnchor<AnchorType, SouthAnchor>> {
        return Item<PairAnchor<AnchorType, SouthAnchor>>(
            view: view, anchor: PairAnchor(first: anchor, second: .instance)
        )
    }
}
