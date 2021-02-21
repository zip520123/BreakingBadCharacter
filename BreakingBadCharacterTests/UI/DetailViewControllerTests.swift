//
//  DetailViewControllerTests.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 21/02/2021.
//

import XCTest
@testable import BreakingBadCharacter
class DetailViewControllerTests: XCTestCase {
    func test_renderTitle() {
        let sut = DetailViewController(makeACharacter())
        _ = sut.view
        XCTAssertEqual(sut.title, "Walter White")
    }
}
