import Foundation
import UIKit

public protocol AnchorHolder {
    var view: Any { get }
}

public protocol HorizontalAnchorHolder: AnchorHolder {
}

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

public protocol VerticalAnchorHolder: AnchorHolder {
}

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

public protocol PositionAnchorHolder: AnchorHolder {
}

extension PositionAnchorHolder {
    public var center: Item<PositionAnchor> {
        return Item(view: view, anchor: .center)
    }
}

public protocol LengthAnchorHolder: AnchorHolder {
}

extension LengthAnchorHolder {
    public var width: Item<LengthAnchor> {
        return Item(view: view, anchor: .width)
    }

    public var height: Item<LengthAnchor> {
        return Item(view: view, anchor: .height)
    }
}

public protocol SizeAnchorHolder: AnchorHolder {
}

extension SizeAnchorHolder {
    public var size: Item<SizeAnchor> {
        return Item(view: view, anchor: .instance)
    }
}

public protocol EdgeAnchorHolder: AnchorHolder {
}

extension EdgeAnchorHolder {
    public var edge: Item<EdgeAnchor> {
        return Item(view: view, anchor: .instance)
    }
}
