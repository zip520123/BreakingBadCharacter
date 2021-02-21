//
//  Router.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import UIKit
protocol Router {
    func route(to character: MovieCharacter)
}

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func route(to character: MovieCharacter) {
        let detailViewController = DetailViewController(character)
        navigationController.pushViewController(detailViewController, animated: false)
    }
}
