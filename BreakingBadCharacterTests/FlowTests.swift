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
    
    func makeSUT(service: Service = MockService(), viewModel: CharactersViewModel = makeViewModel()) -> AppFlow {
        let sut = AppFlow(charactersViewModel: viewModel)
        sut.start()
        return sut
    }
    
}
