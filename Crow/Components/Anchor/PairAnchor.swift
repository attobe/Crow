import Foundation
import UIKit

public struct PairAnchor<FirstAnchor: Anchor, SecondAnchor: Anchor>: Anchor
where FirstAnchor.ConstantType == SecondAnchor.ConstantType {
    public typealias ConstantType = FirstAnchor.ConstantType

    public let first: FirstAnchor
    public let second: SecondAnchor
    public let name: String

    public var description: String {
        return name
    }

    public init(first: FirstAnchor, second: SecondAnchor) {
        self.init(first: first, second: second, name: "\(first).\(second)")
    }

    public init(first: FirstAnchor, second: SecondAnchor, name: String) {
        self.first = first
        self.second = second
        self.name = name
    }

    public func flatten() -> [SingleAnchorType] {
        return first.flatten() + second.flatten()
    }
}

extension PairAnchor: MultipliableAnchor where FirstAnchor: MultipliableAnchor, SecondAnchor: MultipliableAnchor {}
