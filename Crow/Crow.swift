import Foundation
import UIKit

public class Crow {
    public let view: Any
    public private(set) var enablesAutoResizingMaskTranslation = false

    private let constraint = CollectionConstraint()

    public init(view: Any) {
        self.view = view
    }

    public func enableAutoResizingMaskTranslation() -> Self {
        self.enablesAutoResizingMaskTranslation = true
        return self
    }

    public func expr(_ block: (Crow) -> Constraint) -> Self {
        constraint.append(block(self))
        return self
    }

    public func expr(with view: Any, _ block: (Crow, Crow) -> Constraint) -> Self {
        constraint.append(block(self, Crow(view: view)))
        return self
    }

    public func build() -> [NSLayoutConstraint] {
        return constraint.build()
    }

    @discardableResult
    public func activate() -> [NSLayoutConstraint] {
        if let view = view as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = enablesAutoResizingMaskTranslation
        }
        return constraint.activate()
    }
}

extension Crow: HorizontalAnchorHolder {}
extension Crow: VerticalAnchorHolder {}
extension Crow: PositionAnchorHolder {}
extension Crow: LengthAnchorHolder {}
extension Crow: SizeAnchorHolder {}
extension Crow: EdgeAnchorHolder {}
