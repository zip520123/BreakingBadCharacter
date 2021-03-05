//
//  CharactersViewModelTests.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 22/02/2021.
//

import XCTest
import RxSwift
import RxCocoa
@testable import BreakingBadCharacter
class CharactersViewModelTests: XCTestCase {
    func test_initSearchText_isEmpty() {
        let sut = makeViewModel()
        XCTAssertEqual(sut.searchText.value, "")
    }
    
    func test_searchTextChangeState() {
        let sut = makeViewModel()
        let stateSpy = StateSpy(sut)
        sut.searchText.accept("Walter White")
        XCTAssertEqual(stateSpy.texts, ["", "Walter White"])
    }
    
    func test_initSeasonState() {
        let sut = makeViewModel()
        
        XCTAssertEqual([sut.seasionAppearance.value], [0])
    }

    func test_seasonChangeState() {
        let sut = makeViewModel()
        let stateSpy = StateSpy(sut)
        
        sut.seasionAppearance.accept(1)
        XCTAssertEqual(stateSpy.seasonSets, [0,1])
    }
    
    func test_loadAllCharactersFromLocal() {
        let sut = makeSUT()
        XCTAssertNotEqual(sut.currAllCharacters.value.count, 0)
        
    }
    
    func test_charactersSearchEmptyTest_getAllCharacters() {
        let sut = makeSUT()

        let allCharactersCount = sut.currAllCharacters.value.count
        sut.searchText.accept("")
        
        XCTAssertEqual(sut.currFilteredCharacters.value.count, allCharactersCount)
    }
    
    func test_charactersSearchSomeText_getAllCharactersWhosNameContainsText() {
        let sut = makeSUT(service: LocalService())
        sut.searchText.accept("Walter")
        
        for character in sut.currFilteredCharacters.value {
            XCTAssertTrue(character.name.contains("Walter"))
        }
        
    }
    
    func test_charactersSearchSomeTextAndSearchEmpty_getAllCharacters() {

        let sut = makeSUT(service: LocalService())
        
        let allCharactersCount = sut.currAllCharacters.value.count
        sut.searchText.accept("Walter")
        sut.searchText.accept("")
        
        XCTAssertEqual(sut.currFilteredCharacters.value.count, allCharactersCount)
    }
    
    func test_searchSomeTextAndSelectSeasonAppearance_getCharactersWhosNameContainsTextWithSeasonAppearance() {
        
        let sut = makeSUT(service: LocalService())
        sut.searchText.accept("Jane")
        sut.seasionAppearance.accept(1)
        XCTAssertEqual(sut.currFilteredCharacters.value.count, 0)
    }
    
    
    func test_searchSomeTextAndSelectAllSeasonAppearance() {
        let sut = makeSUT(service: LocalService())
        sut.searchText.accept("Jane")
        sut.seasionAppearance.accept(0)
        XCTAssertEqual(sut.currFilteredCharacters.value.count, 1)
    }
    
    
    private class StateSpy {
        private(set) var texts: [String] = []
        private(set) var seasonSets: [Int] = []
        private let disposeBag = DisposeBag()
        init(_ vm: CharactersViewModel) {
            vm.searchText.subscribe { [weak self] (s) in
                self?.texts.append(s)
            } .disposed(by: disposeBag)
            vm.seasionAppearance.subscribe { [weak self] (set) in
                self?.seasonSets.append(set)
            } .disposed(by: disposeBag)
        }
    }
    
    func makeSUT(service: Service = LocalService()) -> CharactersViewModel {
        let sut = CharactersViewModel(service: service)
        sut.start()
        return sut
    }
}

func makeViewModel(service: Service = LocalService()) -> CharactersViewModel {
    return CharactersViewModel(service: service)
}
