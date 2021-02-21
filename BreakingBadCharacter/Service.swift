//
//  Service.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import Foundation
protocol Service {
    func loadData(completionHandler: @escaping ([MovieCharacter], Error?) -> Void)
}

struct LocalService: Service {
    
    enum ServiceError: Error {
        case readFileFail
    }
    
    func loadData(completionHandler: @escaping ([MovieCharacter], Error?) -> Void) {
        guard let path = Bundle.main.url(forResource: "Characters.json", withExtension: nil),
              let data = try? Data(contentsOf: path),
              let model = try? JSONDecoder().decode(MovieCharacters.self, from: data)
              else {
            completionHandler([], ServiceError.readFileFail)
            return
        }
        completionHandler(model,nil)
        
    }
}
