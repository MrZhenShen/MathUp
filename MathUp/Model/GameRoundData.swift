//
//  GameRoundData.swift
//  MathUp
//
//  Created by Yevhen Rozhylo on 20.04.2021.
//

import Foundation

// MARK: - For creating Object for Data

struct GameRoundData{
    var roundNumber: Int!
    var task: String!
    var correctAnswer: Int!
    var userAnswer: Int!
    var roundTime: String!
    var win: Bool!
    
    init(roundNumber: Int, task: String, correctAnswer: Int, userAnswer: Int, roundTime: String) {
        self.roundNumber = roundNumber
        self.task = task
        self.correctAnswer = correctAnswer
        self.userAnswer = userAnswer
        self.roundTime = roundTime
        self.win = (correctAnswer == userAnswer)
    }
}
