//
//  RouterTests.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 21/02/2021.
//

import XCTest
@testable import BreakingBadCharacter


class RouterTests: XCTestCase {
    
    func test_routeToDetail_showSecondPage() {
        let navigationViewController = UINavigationController(rootViewController: UIViewController())
        let sut = NavigationControllerRouter(navigationViewController)
        sut.route(to: makeACharacter())
        XCTAssertEqual(navigationViewController.viewControllers.count, 2)
    }
}
