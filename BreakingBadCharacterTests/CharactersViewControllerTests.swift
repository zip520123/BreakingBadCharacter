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
        let sut = makeSUT()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection:0), 0)
    }
    
    func test_viewDidLoad_withOneCharacter() {
//        let characters: MovieCharacters = [MovieCharacter(charID: <#T##Int#>, name: <#T##String#>, birthday: <#T##Birthday#>, occupation: <#T##[String]#>, img: <#T##String#>, status: <#T##Status#>, nickname: <#T##String#>, appearance: <#T##[Int]#>, portrayed: <#T##String#>, category: <#T##Category#>, betterCallSaulAppearance: <#T##[Int]#>)]
//        let sut = makeSUT(characters)
//        XCTAssertEqual(sut.tableView.numberOfRows(inSection:0), 1)
    }
    
//    func test_viewDidLoad_renderOneCharacter() {
//        let character = MovieCharacters()
//
//    }
    
    func makeSUT(_ characters: MovieCharacters = []) -> CharactersViewController {
        let sut = CharactersViewController(characters)
        _ = sut.view
        return sut
    }
}
