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
        
        charactersViewModel.searchText
            .distinctUntilChanged()
            .withLatestFrom(charactersViewModel.seasionAppearance) {($0, $1)}
            .subscribe(onNext: { [weak self] (query, season) in
                guard let self = self else {return}
                if query == "" {
                    self.currCharacters.accept(self.characters)
                } else {
                    var characters = [MovieCharacter]()
                    for character in self.characters {
                        if character.name.contains(query)  {
                            characters.append(character)
                        }
                    }
                    self.currCharacters.accept(characters)
                }
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
