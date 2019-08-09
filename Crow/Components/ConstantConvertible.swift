import Foundation
import UIKit

public protocol SizeConvertible {
    func toSize() -> CGSize
}

public protocol PointConvertible {
    func toPoint() -> CGPoint
}

public protocol InsetsConvertible {
    func toInsets() -> UIEdgeInsets
}

extension CGFloat: SizeConvertible, PointConvertible, InsetsConvertible {
    public func toSize() -> CGSize {
        return CGSize(width: self, height: self)
    }

    public func toPoint() -> CGPoint {
        return CGPoint(x: self, y: self)
    }

    public func toInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: self, left: self, bottom: self, right: self)
    }
}

extension Double: SizeConvertible, PointConvertible, InsetsConvertible {
    public func toSize() -> CGSize {
        return CGFloat(self).toSize()
    }

    public func toPoint() -> CGPoint {
        return CGFloat(self).toPoint()
    }

    public func toInsets() -> UIEdgeInsets {
        return CGFloat(self).toInsets()
    }
}

extension CGPoint: PointConvertible, InsetsConvertible {
    public func toPoint() -> CGPoint {
        return self
    }

    public func toInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: y, left: x, bottom: 0.0, right: 0.0)
    }
}

extension CGSize: SizeConvertible, InsetsConvertible {
    public func toSize() -> CGSize {
        return self
    }

    public func toInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: height, left: width, bottom: height, right: width)
    }
}

extension UIEdgeInsets: InsetsConvertible {
    public func toInsets() -> UIEdgeInsets {
        return self
    }
}
