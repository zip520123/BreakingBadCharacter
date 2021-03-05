//
//  CharactersViewControllerTests.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 21/02/2021.
//

import XCTest
import RxSwift
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
        let disposeBag = DisposeBag()
        let viewModel = CharactersViewModel()
        
        viewModel.didSelectCharacter.subscribe { (character) in
            isSelect = true
        }.disposed(by: disposeBag)
        let sut = makeSUT([makeACharacter()], viewModel: viewModel)
        
        sut.tableView.select(at: 0)
        
        XCTAssertTrue(isSelect)
    }

    func makeSUT(_ characters: MovieCharacters = [], viewModel: CharactersViewModel = CharactersViewModel() ) -> CharactersViewController {
        let sut = CharactersViewController(characters, viewModel: viewModel)
        viewModel.currCharacter.accept(characters)
        _ = sut.view
        return sut
    }
    

}


