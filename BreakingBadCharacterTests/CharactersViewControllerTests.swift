//
//  CharactersViewControllerTests.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 21/02/2021.
//

import XCTest
@testable import BreakingBadCharacter
class CharactersViewControllerTests: XCTestCase {
    func test_viewDidLoad_withZeroCharacter() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection:0), 0)
    }
    
    func test_viewDidLoad_withOneCharacter() {
        let sut = makeSUT([makeACharacter()])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection:0), 1)
    }
    
    func test_viewDidLoad_renderOneCharacterName() {
        let sut = makeSUT([makeACharacter()])
        XCTAssertEqual(sut.tableView.title(at: 0), "Walter White")
    }

    func makeSUT(_ characters: MovieCharacters = []) -> CharactersViewController {
        let sut = CharactersViewController(characters)
        _ = sut.view
        return sut
    }
    
    func makeACharacter() -> MovieCharacter {
        MovieCharacter(
            charID: 1,
            name: "Walter White",
            birthday: BreakingBadCharacter.Birthday.the09071958,
            occupation: ["High School Chemistry Teacher", "Meth King Pin"],
            img: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
            status: BreakingBadCharacter.Status.presumedDead,
            nickname: "Heisenberg",
            appearance: [1, 2, 3, 4, 5],
            portrayed: "Bryan Cranston",
            category: BreakingBadCharacter.Category.breakingBad,
            betterCallSaulAppearance: [])
    }
}

extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return self.cell(at: row)?.textLabel?.text
    }
    
    func select(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
    
    func deselect(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        deselectRow(at: indexPath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
}
