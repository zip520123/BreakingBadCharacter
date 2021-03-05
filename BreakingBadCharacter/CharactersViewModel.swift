//
//  CharactersViewModel.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 22/02/2021.
//

import RxCocoa

struct CharactersViewModel {
    let seasionAppearance: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    let searchText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    let didSelectCharacter: PublishRelay<MovieCharacter> = PublishRelay<MovieCharacter>()
    let currFilteredCharacters: BehaviorRelay<[MovieCharacter]> = BehaviorRelay<[MovieCharacter]>(value: [])
}
