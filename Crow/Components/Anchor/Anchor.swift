import Foundation
import UIKit

public protocol AnchorType: CustomStringConvertible {}

public protocol SingleAnchorType: AnchorType {
    var attribute: NSLayoutConstraint.Attribute { get }

    func transform(relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation
    func transform<ConstantType: Constant>(constant: ConstantType) -> CGFloat?
}

extension SingleAnchorType {
    public func transform(relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation {
        return relation
    }

    public func flatten() -> [SingleAnchorType] {
        return [self]
    }
}

public protocol Anchor: AnchorType {
    associatedtype ConstantType: Constant

    func flatten() -> [SingleAnchorType]
}

public protocol SingleAnchor: SingleAnchorType, Anchor {
    func extract(constant: ConstantType) -> CGFloat
}

extension SingleAnchor {
    public func transform<ConstantType: Constant>(constant: ConstantType) -> CGFloat? {
        guard let constant = constant as? Self.ConstantType else { return nil }
        return extract(constant: constant)
    }
}

public protocol MultipliableAnchor {}
