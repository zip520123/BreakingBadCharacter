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
