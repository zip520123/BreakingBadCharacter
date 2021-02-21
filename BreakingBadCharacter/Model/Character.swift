//
//  Character.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import Foundation
struct MovieCharacter: Codable {
    let charID: Int
    let name: String
    let birthday: Birthday
    let occupation: [String]
    let img: String
    let status: Status
    let nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: Category
    let betterCallSaulAppearance: [Int]
    
    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
}

enum Birthday: String, Codable {
    case the07081993 = "07-08-1993"
    case the08111970 = "08-11-1970"
    case the09071958 = "09-07-1958"
    case the09241984 = "09-24-1984"
    case unknown = "Unknown"
}

enum Category: String, Codable {
    case betterCallSaul = "Better Call Saul"
    case breakingBad = "Breaking Bad"
    case breakingBadBetterCallSaul = "Breaking Bad, Better Call Saul"
}

enum Status: String, Codable {
    case alive = "Alive"
    case deceased = "Deceased"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}

typealias MovieCharacters = [MovieCharacter]
