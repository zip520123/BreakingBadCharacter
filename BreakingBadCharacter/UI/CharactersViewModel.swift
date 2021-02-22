//
//  CharactersViewModel.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 22/02/2021.
//

import RxCocoa

struct CharactersViewModel {
    var searchText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}
