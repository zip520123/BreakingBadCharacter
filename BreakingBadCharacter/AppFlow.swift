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
        charactersViewController = CharactersViewController(characters, viewModel: charactersViewModel)
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
        
        Observable.combineLatest(
            charactersViewModel.searchText
                                    .distinctUntilChanged(),
            charactersViewModel.seasionAppearance
        ).subscribe(onNext: { [weak self] (query, season) in
                guard let self = self else {return}
                let allCharacters = self.characters
                var charactersFilterByName = [MovieCharacter]()
                
                
                if query == "" {
                    charactersFilterByName += allCharacters
                } else {
                    for character in allCharacters {
                        if character.name.contains(query)  {
                            charactersFilterByName.append(character)
                        }
                    }
                }
                
                var charactersFilterBySeason = [MovieCharacter]()
                
                if season == 0 {
                    charactersFilterBySeason += charactersFilterByName
                } else {
                    for character in charactersFilterByName {
                        let characterSeasionSet = Set(character.appearance)
                        if characterSeasionSet.contains(season) {
                            charactersFilterBySeason.append(character)
                        }
                    }
                }
                
                
                self.currCharacters.accept(charactersFilterBySeason)
            })
            .disposed(by: disposeBag)
        
        currCharacters.subscribe {[weak self] (characters) in
            self?.charactersViewController.update(characters: characters)
        }.disposed(by: disposeBag)
        
        charactersViewModel.didSelectCharacter.subscribe {[weak self] (character) in
            self?.didSelectModelHandler(character)
        }.disposed(by: disposeBag)

    }
}
