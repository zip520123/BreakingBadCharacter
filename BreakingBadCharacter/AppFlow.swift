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
    let currAllCharacters: BehaviorRelay<[MovieCharacter]>
    private let disposeBag = DisposeBag()
    
    private let charactersViewController: CharactersViewController
    private let navigationControllerRouter: NavigationControllerRouter
    let navigationController: UINavigationController
    private let charactersViewModel: CharactersViewModel
    
    init(charactersViewModel: CharactersViewModel) {
        self.charactersViewModel = charactersViewModel
        self.currAllCharacters = charactersViewModel.currAllCharacters
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
        currAllCharacters.accept(characters)
    }
    
    func start() {
        charactersViewModel.service.loadData {[weak self] (characters, error) in
            guard let self = self else {return}
            self.dataHandler(characters, error: error)
        }
    }
    
    private func didSelectModelHandler(_ character: MovieCharacter) {
        navigationControllerRouter.route(to: character)
    }
    
    
    private func rxbinding() {
        
        charactersViewModel.didSelectCharacter.subscribe {[weak self] (character) in
            self?.didSelectModelHandler(character)
        }.disposed(by: disposeBag)

    }
}
