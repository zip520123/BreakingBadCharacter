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
}

func makeViewModel(service: Service = LocalService()) -> CharactersViewModel {
    return CharactersViewModel(service: service)
}
