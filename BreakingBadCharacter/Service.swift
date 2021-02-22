//
//  Service.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import Foundation

enum ServiceError: Error {
    case urlIsNil
    case readFileFail
    case decodeError
}

protocol Service {
    func loadData(completionHandler: @escaping ([MovieCharacter], Error?) -> Void)
}

struct ApiService: Service {
    public let session: URLSession
    public let scheme = "https"
    public let host = "breakingbadapi.com"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    private func defualtURLComponets() -> URLComponents {
        var urlc = URLComponents()
        urlc.host = host
        urlc.scheme = scheme
        return urlc
    }
    
    func loadData(completionHandler: @escaping ([MovieCharacter], Error?) -> Void) {
        var urlc = defualtURLComponets()
        urlc.path = "/api/characters"
        
        guard let url = urlc.url else {
            completionHandler([], ServiceError.urlIsNil)
            return
        }
        print(url)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler([], error)
                return
            }
            guard let data = data, let model = try? JSONDecoder().decode(MovieCharacters.self, from: data) else {
                completionHandler([], ServiceError.decodeError)
                return
            }
            completionHandler(model, nil)
        }
        
        task.resume()
    }
}

struct LocalService: Service {
    
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
