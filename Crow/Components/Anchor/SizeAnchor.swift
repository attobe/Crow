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

    public func extract(constant: SizeConstant) -> CGFloat {
        switch self {
        case .width: return constant.value.width
        case .height: return constant.value.height
        }
    }
}
