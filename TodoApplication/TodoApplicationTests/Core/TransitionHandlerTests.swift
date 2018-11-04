@testable import TodoApplication
import XCTest

final class TransitionHandlerTests: TestCase {
    // MARK: - Tests for AlertDisplayable
    func testOpenModule_pushesViewController() {
        // given
        let viewController = UIViewController()
        let anotherViewController = UIViewController()
        let navigationController = UINavigationController(
            rootViewController: viewController
        )
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        // when
        let animationExpectation = expectation(description: "wait for animation")
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            animationExpectation.fulfill()
        }
        viewController.openModule(anotherViewController)
        CATransaction.commit()
        waitForExpectations(timeout: 2)
        
        // then
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers[safe: 0], viewController)
        XCTAssertEqual(navigationController.viewControllers[safe: 1], anotherViewController)
    }
}

