import Foundation
import UIKit

public enum LengthAnchor: SingleAnchor, MultipliableAnchor {
    public typealias ConstantType = SizeConstant

    case width
    case height

    public var description: String {
        switch self {
        case .width: return "width"
        case .height: return "height"
        }
    }

    public var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .width: return .width
        case .height: return .height
        }
    }

    public static func + (lhs: LengthAnchor, rhs: LengthAnchor) -> ListAnchor<LengthAnchor> {
        return ListAnchor<LengthAnchor>(anchors: [lhs, rhs])
    }

    public func extract(constant: SizeConstant) -> CGFloat {
        return attribute == .width ? constant.value.width : constant.value.height
    }
}

public struct SizeAnchor: Anchor, MultipliableAnchor {
    public typealias ConstantType = SizeConstant

    public static let instance = SizeAnchor()

    public var description: String {
        return "size"
    }

    private init() {}

    public func flatten() -> [SingleAnchorType] {
        return [LengthAnchor.width, LengthAnchor.height]
    }
}

// MARK: Anchor holders

public protocol LengthAnchorHolder: AnchorHolder {}

extension LengthAnchorHolder {
    public var width: Item<LengthAnchor> {
        return Item(view: view, anchor: .width)
    }

    public var height: Item<LengthAnchor> {
        return Item(view: view, anchor: .height)
    }
}

public protocol SizeAnchorHolder: AnchorHolder {}

extension SizeAnchorHolder {
    public var size: Item<SizeAnchor> {
        return Item(view: view, anchor: .instance)
    }
}
