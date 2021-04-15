//
//  Game.swift
//  ZhenShen
//
//  Created by Yevhen Rozhylo on 01.04.2021.
//

import Foundation

class Game{ // Model
    static var firstNum: Int!, secondNum: Int!
    static var correctAnswer: Int!
    
    static var btnValueSet: [Int]!
    static var correctBtnAnswer: Int!
    
    static var roundsAmount: Int = 5
    static var currentRound: Int = 0
    
    init(firstNum:Int, secondNum:Int, btnSet: [Int], correctBtnAnswer:Int) {
        Game.firstNum = firstNum
        Game.secondNum = secondNum

        Game.correctAnswer = Game.firstNum + Game.secondNum
        
        Game.btnValueSet = btnSet
        
        Game.correctBtnAnswer = correctBtnAnswer
    }
}
