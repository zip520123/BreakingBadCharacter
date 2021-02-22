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
        XCTAssertEqual((sut.tableView.cell(at: 0) as? CharacterCell)?.nameLabel.text, "Walter White")
    }
    
    func test_viewDidLoad_title() {
        XCTAssertEqual(makeSUT().title, "List of Breaking Bad characters")
    }
    
    
    func test_viewDidLoad_detectWhenDidSelectModel() {
        var isSelect = false
        let handler : (MovieCharacter) -> Void = {
            character in
            isSelect = true
        }
        let sut = makeSUT([makeACharacter()], didSelectModelHandler: handler)
        
        sut.tableView.select(at: 0)
        
        XCTAssertTrue(isSelect)
    }

    func makeSUT(_ characters: MovieCharacters = [], didSelectModelHandler: @escaping (MovieCharacter)->Void = {_ in} ) -> CharactersViewController {
        let sut = CharactersViewController(characters, didSelectModelHandler: didSelectModelHandler, viewModel: CharactersViewModel())
        _ = sut.view
        return sut
    }
    

}


