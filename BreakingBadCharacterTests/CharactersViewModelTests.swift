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
    
    private class StateSpy {
        private(set) var texts: [String] = []
        private let disposeBag = DisposeBag()
        init(_ vm: CharactersViewModel) {
            vm.searchText.subscribe { [weak self] (s) in
                self?.texts.append(s)
            } .disposed(by: disposeBag)
        }
    }
}
