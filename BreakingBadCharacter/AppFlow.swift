//
//  AppFlow.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import Foundation
class AppFlow {
    private let service: Service
    private let dataHandler: (([MovieCharacter], Error?)->Void)
    
    init(service: Service,
         dataHandler: @escaping (([MovieCharacter], Error?)->Void) = {(_,_) in }) {
        self.service = service
        self.dataHandler = dataHandler
    }
    
    func start() {
        service.loadData {[weak self] (characters, error) in
            guard let self = self else {return}
            self.dataHandler(characters, error)
        }
    }
}
