//
//  CharactersViewModel.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 22/02/2021.
//
import RxSwift
import RxCocoa

struct CharactersViewModel {
    let seasionAppearance: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    let searchText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    let didSelectCharacter: PublishRelay<MovieCharacter> = PublishRelay<MovieCharacter>()
    let currFilteredCharacters: BehaviorRelay<[MovieCharacter]> = BehaviorRelay<[MovieCharacter]>(value: [])
    let currAllCharacters: BehaviorRelay<[MovieCharacter]> = BehaviorRelay<[MovieCharacter]>(value: [])
    let service: Service
    let disposeBag = DisposeBag()
    init(service: Service) {
        self.service = service
    }
    
    func start() {
        rxbinding()
        service.loadData { (characters, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            currAllCharacters.accept(characters)
        }
    }
    
    private let searchName: (String) -> (MovieCharacter) -> Bool = { query in
        
        let filter: (MovieCharacter) -> Bool = { character in
            if query == "" {
                return true
            } else {
                return character.name.contains(query)
            }
        }
        
        return filter
    }
    
    private let seasonAppearance: (Int) -> (MovieCharacter) -> Bool = { season in
        
        let seasonFilter: (MovieCharacter) -> Bool = { character in
            if season == 0 {
                return true
            } else {
                let characterSeasionSet = Set(character.appearance)
                return characterSeasionSet.contains(season)
            }
        }
        
        return seasonFilter
    }
    
    private func movieCharacterFilterByNameAndSeason(name: String, season: Int, characters: [MovieCharacter]) -> [MovieCharacter] {
        return characters
            .filter(searchName(name))
            .filter(seasonAppearance(season))
    }
    
    private func rxbinding() {

        Observable.combineLatest(
            searchText.skip(1).distinctUntilChanged(),
            seasionAppearance
        ).withLatestFrom(currAllCharacters) {(arg0, characters) in
            let (name, season) = arg0
            return (name, season, characters)
        }
        .map(movieCharacterFilterByNameAndSeason)
        .bind(to: currFilteredCharacters)
        .disposed(by: disposeBag)
        
    }
}
