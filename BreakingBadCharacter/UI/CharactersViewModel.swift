//
//  CharactersViewModel.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 22/02/2021.
//

import RxCocoa

struct CharactersViewModel {
    var seasionAppearance: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    var searchText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}
