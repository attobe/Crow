import Foundation
import UIKit

public class CollectionConstraint: Constraint {
    public private(set) var constraints: [Constraint] = []

    public var description: String {
        return constraints.map { $0.description }.joined(separator: " && ")
    }

    public convenience init() {
        self.init(constraints: [])
    }

    private init(constraints: [Constraint]) {
        self.constraints = constraints
    }

    public func build() -> [NSLayoutConstraint] {
        return constraints.flatMap { $0.build() }
    }
}

extension CollectionConstraint {
    public func append(_ constraint: Constraint) {
        constraints.append(constraint)
    }
}
