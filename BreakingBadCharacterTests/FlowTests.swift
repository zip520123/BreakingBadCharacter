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
        XCTAssertEqual(sut.currAllCharacters.value, [])
    }
    
    func test_charactersLoadFromLocal() {
        let sut = makeSUT(service: LocalService())
        XCTAssertNotEqual(sut.currAllCharacters.value.count, 0)
    }
    
    func test_charactersSearchEmptyTest_getAllCharacters() {
        let viewModel = CharactersViewModel()
        
        let sut = makeSUT(service: LocalService(), viewModel: viewModel)
        
        let allCharactersCount = sut.currAllCharacters.value.count
        viewModel.searchText.accept("")
        
        XCTAssertEqual(sut.currAllCharacters.value.count, allCharactersCount)
    }
    
    func test_charactersSearchSomeText_getAllCharactersWhosNameContainsText() {
        let viewModel = CharactersViewModel()

        let sut = makeSUT(service: LocalService(), viewModel: viewModel)
        viewModel.searchText.accept("Walter")
        
        for character in sut.currAllCharacters.value {
            XCTAssertTrue(character.name.contains("Walter"))
        }

    }
    
    func test_charactersSearchSomeTextAndSearchEmpty_getAllCharacters() {
        let viewModel = CharactersViewModel()
        
        let sut = makeSUT(service: LocalService(), viewModel: viewModel)
        
        let allCharactersCount = sut.currAllCharacters.value.count
        viewModel.searchText.accept("Walter")
        viewModel.searchText.accept("")
        
        XCTAssertEqual(sut.currAllCharacters.value.count, allCharactersCount)
    }
    
    func test_searchSomeTextAndSelectSeasonAppearance_getCharactersWhosNameContainsTextWithSeasonAppearance() {
        let viewModel = CharactersViewModel()
        let sut = makeSUT(service: LocalService(), viewModel: viewModel)
        viewModel.searchText.accept("Jane")
        viewModel.seasionAppearance.accept(1)
        XCTAssertEqual(sut.currAllCharacters.value.count, 0)
    }
    
    func test_searchSomeTextAndSelectAllSeasonAppearance() {
        let viewModel = CharactersViewModel()
        let sut = makeSUT(service: LocalService(), viewModel: viewModel)
        viewModel.searchText.accept("Jane")
        viewModel.seasionAppearance.accept(0)
        XCTAssertEqual(sut.currAllCharacters.value.count, 1)
    }
    
    func makeSUT(service: Service = MockService(), viewModel: CharactersViewModel = CharactersViewModel()) -> AppFlow {
        let sut = AppFlow(service: service, charactersViewModel: viewModel)
        sut.start()
        return sut
    }
    
}
