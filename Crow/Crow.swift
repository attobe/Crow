import Foundation
import UIKit

public class Crow: AnchorHolder {
    public let view: AnyObject
    public private(set) var enablesAutoResizingMaskTranslation = false
    public let constraints = CollectionConstraint()

    public init(view: AnyObject) {
        self.view = view
    }

    public func enableAutoResizingMaskTranslation() -> Self {
        self.enablesAutoResizingMaskTranslation = true
        return self
    }

    public func expr(_ block: (Crow) -> Constraint) -> Self {
        constraints.append(block(self))
        return self
    }

    public func expr(with view: AnyObject, _ block: (Crow, Crow) -> Constraint) -> Self {
        constraints.append(block(self, Crow(view: view)))
        return self
    }

    public func build() -> [NSLayoutConstraint] {
        return constraints.build()
    }

    @discardableResult
    public func activate() -> [NSLayoutConstraint] {
        if let view = view as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = enablesAutoResizingMaskTranslation
        }
        return constraints.activate()
    }
}
