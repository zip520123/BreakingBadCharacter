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
        let viewModel = CharactersViewModel()
        let service = MockService()
        let sut = AppFlow(service: service, charactersViewModel: viewModel)
        service.loadData { (_, _) in
            isLoaded = true
        }
        sut.start()
        XCTAssertTrue(isLoaded)
    }
    
    func test_charactersInitState() {
        let sut = AppFlow(service: MockService(), charactersViewModel: CharactersViewModel())
        sut.start()
        
        XCTAssertEqual(sut.currCharacters.value, [])
    }
    
    func test_charactersLoadFromLocal() {
        let sut = AppFlow(service: LocalService(), charactersViewModel: CharactersViewModel())
        sut.start()
        XCTAssertNotEqual(sut.currCharacters.value.count, 0)
    }
    
    
}
