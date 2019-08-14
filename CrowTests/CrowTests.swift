import XCTest
@testable import Crow

class CrowTests: XCTestCase {

    func testExample() {
        let view = UIView()

        let subview = UIView()
        view.addSubview(subview)
        subview.crowed { crow in
            crow.left.right.top.bottom == view.crow.left.right.top.bottom - 1.0
        }

        print((subview.crow.north.south == view.crow.north.south - 2.0
            && subview.crow.edge == view.crow.edge).build())

        view.bounds.size = CGSize(width: 10.0, height: 10.0)
        subview.bounds = CGRect(x: 5.0, y: 5.0, width: 0.0, height: 0.0)
        view.setNeedsLayout()
        view.layoutIfNeeded()

        print(view.bounds.size)
        print(subview.frame.origin, subview.frame.size)
    }
}
