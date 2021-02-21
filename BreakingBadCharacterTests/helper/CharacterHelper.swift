//
//  CharacterHelper.swift
//  BreakingBadCharacterTests
//
//  Created by zip520123 on 21/02/2021.
//

@testable import BreakingBadCharacter
func makeACharacter() -> MovieCharacter {
    MovieCharacter(
        charID: 1,
        name: "Walter White",
        birthday: BreakingBadCharacter.Birthday.the09071958,
        occupation: ["High School Chemistry Teacher", "Meth King Pin"],
        img: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
        status: BreakingBadCharacter.Status.presumedDead,
        nickname: "Heisenberg",
        appearance: [1, 2, 3, 4, 5],
        portrayed: "Bryan Cranston",
        category: BreakingBadCharacter.Category.breakingBad,
        betterCallSaulAppearance: [])
}
