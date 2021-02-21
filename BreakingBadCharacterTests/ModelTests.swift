//
//  ModelTests.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 21/02/2021.
//

import XCTest
import Foundation
@testable import BreakingBadCharacter
class ModelTests: XCTestCase {

    func test_modelDecode() throws {
        let input = try XCTUnwrap(readString(from: "Characters.json").data(using: .utf8), "Fail to read json file.")
        let model = try JSONDecoder().decode(MovieCharacter.self, from: input)
        for item in model {
            print(item)
        }
        XCTAssertEqual(model[0].name, "Walter White")
    }
    
    
    func readString(from file: String) throws -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: file, withExtension: nil)!
        let data = try Data(contentsOf: path)
        return String(data: data, encoding: .utf8)!
    }
}
