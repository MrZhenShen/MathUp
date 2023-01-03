//
//  Game.swift
//  ZhenShen
//
//  Created by Yevhen Rozhylo on 01.04.2021.
//

import Foundation

class Game {
    
    // MARK: - Data array

    private var roundsData: [GameRoundData] = []
    
    // MARK: - Constants
    
    private let operandRange = 0..<50
    private let answerRange = 0..<100
    private var answersArrayRange: Range<Int> {
        0..<answersAmount
    }
    
    // MARK: - Game config
    
    private var roundsAmount: Int = 5
    private var answersAmount = 4
    
    // MARK: - Round values
    
    private(set) var currentRound = 0
    private(set) var answers = [Int]()
    private var firstNumber = 0
    private var secondNumber = 0
    
    private var correctAnswer: Int {
        firstNumber + secondNumber
    }
    
    // TODO: - Would be perfect to have other operations except +
    var currentTask: String {
        "\(firstNumber) + \(secondNumber)"
    }
    
    // MARK: - State
    
    enum GameState {
        case notStarted
        case inProgress
        case finished
    }
    
    var currentState: GameState {
        switch currentRound {
        case 0:
            return .notStarted
            
        case roundsAmount:
            return .finished
            
        default:
            return .inProgress
        }
    }
    
    // MARK: - Main logic
    
    func setRoundsCount(with value: Int) {
        self.roundsAmount = value
    }
    
    func startNextRound() {
        firstNumber = generateRandomNumber(in: operandRange)
        secondNumber = generateRandomNumber(in: operandRange)
        
        answers.removeAll()
        for _ in 0..<answersAmount {
            answers.append(generateRandomNumber(in: answerRange))
        }
        
        let correctAnswerIndex = generateRandomNumber(in: answersArrayRange)
        answers[correctAnswerIndex] = correctAnswer
        
        currentRound += 1
    }
    
    func checkResult(for index: Int) -> Bool {
        answers[index] == correctAnswer
    }
    
    func reset() {
        currentRound = 0
    }
    
    private func generateRandomNumber(in range: Range<Int>) -> Int {
        Int.random(in: range)
    }
    
    // MARK: - Rounds Data processing
    
    func updateRoundsData(for index: Int) {
        roundsData.append(GameRoundData(roundNumber: currentRound, task: currentTask, correctAnswer: correctAnswer, userAnswer: answers[index], roundTime: "XX:XX:XX"))
    }
    
    func getRoundsData() -> [GameRoundData] {
        return roundsData
    }
    
    func clearRoundsData() {
        roundsData = []
    }
}
