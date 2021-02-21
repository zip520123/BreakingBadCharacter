//
//  RouterTests.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 21/02/2021.
//

import XCTest
@testable import BreakingBadCharacter

protocol Router {
    func route(to: MovieCharacter)
}

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func route(to: MovieCharacter) {
        let detailViewController = DetailViewController()
        navigationController.pushViewController(detailViewController, animated: false)
    }
}


class RouterTests: XCTestCase {
    
    func test_routeToDetail_showSecondPage() {
        let navigationViewController = UINavigationController(rootViewController: UIViewController())
        let sut = NavigationControllerRouter(navigationViewController)
        sut.route(to: makeACharacter())
        XCTAssertEqual(navigationViewController.viewControllers.count, 2)
    }
}
