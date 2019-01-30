import Foundation
import UIKit

public struct AttributedConstant {
    public let attribute: NSLayoutConstraint.Attribute
    public let constant: CGFloat

    public init(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        self.attribute = attribute
        self.constant = constant
    }
}
