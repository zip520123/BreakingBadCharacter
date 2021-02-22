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
        let sut = CharactersViewModel()
        XCTAssertEqual(sut.searchText.value, "")
    }
    
    func test_searchTextChangeState() {
        let sut = CharactersViewModel()
        let stateSpy = StateSpy(sut)
        sut.searchText.accept("Walter White")
        XCTAssertEqual(stateSpy.texts, ["", "Walter White"])
    }
    
    func test_initSeasonState() {
        let sut = CharactersViewModel()
        let stateSpy = StateSpy(sut)
        XCTAssertEqual([sut.seasionAppearance.value], stateSpy.seasonSets)
    }

    func test_seasonChangeState() {
        let sut = CharactersViewModel()
        let stateSpy = StateSpy(sut)
        var set = sut.seasionAppearance.value
        set.insert(1)
        sut.seasionAppearance.accept(set)
        XCTAssertEqual([Set(), Set([1])], stateSpy.seasonSets)
    }
    
    private class StateSpy {
        private(set) var texts: [String] = []
        private(set) var seasonSets: [Set<Int>] = []
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
