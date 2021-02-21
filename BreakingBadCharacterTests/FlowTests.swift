//
//  FlowTests.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 21/02/2021.
//

import XCTest
@testable import BreakingBadCharacter

class AppFlow {
    private let service: Service
    private let dataHandler: (([MovieCharacter], Error?)->Void)
    init(service: Service, handler: @escaping (([MovieCharacter], Error?)->Void) = {(_,_) in }) {
        self.service = service
        self.dataHandler = handler
    }
    
    func start() {
        service.loadData {[weak self] (characters, error) in
            guard let self = self else {return}
            self.dataHandler(characters, error)
        }
    }
}

protocol Service {
    func loadData(completionHandler: @escaping ([MovieCharacter], Error?) -> Void)
}

class MockService: Service {
    func loadData(completionHandler: @escaping ([MovieCharacter], Error?) -> Void) {
        completionHandler([],nil)
    }
}
 

class FlowTests: XCTestCase {

    func test_getDataWhenDataFetchCompletion() {
        var isLoaded = false
        
        let sut = AppFlow(service: MockService()) { (characters, error) in
            isLoaded = true
        }
        sut.start()
        XCTAssertTrue(isLoaded)
    }
}
