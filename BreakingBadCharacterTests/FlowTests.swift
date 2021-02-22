//
//  FlowTests.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 21/02/2021.
//

import XCTest
@testable import BreakingBadCharacter

class MockService: Service {
    func loadData(completionHandler: @escaping ([MovieCharacter], Error?) -> Void) {
        completionHandler([],nil)
    }
}
 

class FlowTests: XCTestCase {

    func test_getDataWhenDataFetchCompletion() {
        var isLoaded = false
        let service = MockService()
        let sut = makeSUT(service: service)
        service.loadData { (_, _) in
            isLoaded = true
        }
        sut.start()
        XCTAssertTrue(isLoaded)
    }
    
    func test_charactersInitState() {
        let sut = makeSUT()
        XCTAssertEqual(sut.currCharacters.value, [])
    }
    
    func test_charactersLoadFromLocal() {
        let sut = makeSUT(service: LocalService())
        XCTAssertNotEqual(sut.currCharacters.value.count, 0)
    }
    
    func test_charactersSearchEmptyTest_getAllCharacters() {
        let viewModel = CharactersViewModel()
        
        let sut = makeSUT(service: LocalService(), viewModel: viewModel)
        
        let allCharactersCount = sut.currCharacters.value.count
        viewModel.searchText.accept("")
        
        XCTAssertEqual(sut.currCharacters.value.count, allCharactersCount)
    }
    
    func test_charactersSearchSomeText_getAllCharactersWhosNameContainsText() {
        let viewModel = CharactersViewModel()

        let sut = makeSUT(service: LocalService(), viewModel: viewModel)
        viewModel.searchText.accept("Walter")
        
        for character in sut.currCharacters.value {
            XCTAssertTrue(character.name.contains("Walter"))
        }

    }
    
    func test_searchSomeTextAndSelectSeasonAppearance_getCharactersWhosNameContainsTextWithSeasonAppearance() {
        let viewModel = CharactersViewModel()
        let sut = makeSUT(service: LocalService(), viewModel: viewModel)
        viewModel.searchText.accept("Jane")
        viewModel.seasionAppearance.accept(1)
        XCTAssertEqual(sut.currCharacters.value.count, 0)
    }
    
    func makeSUT(service: Service = MockService(), viewModel: CharactersViewModel = CharactersViewModel()) -> AppFlow {
        let sut = AppFlow(service: service, charactersViewModel: viewModel)
        sut.start()
        return sut
    }
    
}
