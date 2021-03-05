//
//  AppFlow.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import Foundation
import RxSwift
import RxCocoa

class AppFlow {
    private let service: Service
    private var characters = [MovieCharacter]()
    let currCharacters: BehaviorRelay<[MovieCharacter]> = BehaviorRelay<[MovieCharacter]>(value: [])
    private let disposeBag = DisposeBag()
    
    private let charactersViewController: CharactersViewController
    private let navigationControllerRouter: NavigationControllerRouter
    let navigationController: UINavigationController
    private let charactersViewModel: CharactersViewModel
    
    init(service: Service, charactersViewModel: CharactersViewModel) {
        self.service = service
        self.charactersViewModel = charactersViewModel
        charactersViewController = CharactersViewController(viewModel: charactersViewModel)
        navigationController = UINavigationController(rootViewController: charactersViewController)
        navigationControllerRouter = NavigationControllerRouter(navigationController)
        rxbinding()
    }
    
    private func dataHandler(_ characters: [MovieCharacter], error: Error?) {
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
        self.characters = characters
        currCharacters.accept(characters)
    }
    
    func start() {
        service.loadData {[weak self] (characters, error) in
            guard let self = self else {return}
            self.dataHandler(characters, error: error)
        }
    }
    
    private func didSelectModelHandler(_ character: MovieCharacter) {
        navigationControllerRouter.route(to: character)
    }
    
    
    private func rxbinding() {
        let searchName: (String) -> (MovieCharacter) -> Bool = { query in
            
            let filter: (MovieCharacter) -> Bool = { character in
                if query == "" {
                    return true
                } else {
                    return character.name.contains(query)
                }
            }
            
            return filter
        }
        
        let seasonAppearance: (Int) -> (MovieCharacter) -> Bool = { season in
            
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
        
        let movieCharacterFilterByNameAndSeason: (String, Int, [MovieCharacter]) -> [MovieCharacter] = {
            name, season, characters in
            return characters
                .filter(searchName(name))
                .filter(seasonAppearance(season))
        }
        
        Observable.combineLatest(
            charactersViewModel.searchText
                                    .distinctUntilChanged(),
            charactersViewModel.seasionAppearance
        ).map({ [weak self]  (name, season) -> [MovieCharacter] in
            guard let self = self else {return []}
            return movieCharacterFilterByNameAndSeason(name, season, self.characters)
        })
        .bind(to: currCharacters)
        .disposed(by: disposeBag)
        
        charactersViewModel.didSelectCharacter.subscribe {[weak self] (character) in
            self?.didSelectModelHandler(character)
        }.disposed(by: disposeBag)

    }
}
