//
//  GameViewController.swift
//  ZhenShen
//
//  Created by abb on 11.02.2021.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private var answerButtons: [UIButton]!
    @IBOutlet private var taskLabel: UILabel!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var setRoundsLabel: UILabel!
    @IBOutlet private var currentRoundLabel: UILabel!
    @IBOutlet private var roundsCountPicker: UIPickerView!
    
    // MARK: - Model
    
    private let game = Game()
    private var gameProgress = Progress(totalUnitCount: 0)
    
    private var roundsNumberRange: [Int] {
        let roundsMinimalValue = 5
        let roundsMaximalValue = 100
        return Array(roundsMinimalValue...roundsMaximalValue)
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setInitialRoundsNumber()
    }
    
    private func setInitialRoundsNumber() {
        if let minimalRoundsNumber = roundsNumberRange.first {
            game.setRoundsCount(with: minimalRoundsNumber)
            gameProgress.totalUnitCount = Int64(minimalRoundsNumber)
        }
    }
}

// MARK: - Actions

private extension GameViewController {
    @IBAction func handleAnswerPress(_ sender: UIButton) {
        guard let index = answerButtons.firstIndex(of: sender) else {
            return
        }
        
        handleAnswerPress(at: index)
    }
    
    func handleAnswerPress(at index: Int) {
        switch game.currentState {
        case .notStarted:
            startGame()
            
        case .inProgress:
            // TODO: - That's where you can update user score
            checkUserAnswer(for: index)
            startNextRound()

        case .finished:
            // TODO: Would be really nice to show user result here
            resetScene()
            game.reset()
        }
        
        updateCurrentProgress()
    }
    
    func updateCurrentProgress() {
        gameProgress.completedUnitCount = Int64(game.currentRound)
        progressView.setProgress(Float(gameProgress.fractionCompleted), animated: true)
    }
    
    func startGame() {
        setCurrentRoundLabelVisibility(isVisible: true)
        setRoundNumberPickerVisibility(isVisible: false)
        startNextRound()
    }
    
    func checkUserAnswer(for index: Int) {
        let isResultCorrect = game.checkResult(for: index)
        view.backgroundColor = isResultCorrect
            ? StyleManager.successBackground
            : StyleManager.failureBackground
    }
    
    func startNextRound() {
        game.startNextRound()
        currentRoundLabel.text = "\(game.currentRound)"
        taskLabel.text = game.currentTask
        answerButtons.enumerated().forEach { index, button in
            button.setTitle("\(game.answers[index])" , for: .normal)
        }
    }
}


// MARK: - UI Methods

private extension GameViewController {
    func setupUI() {
        answerButtons.forEach { $0.addActionButtonShadow() }
    }
    
    func resetScene() {
        answerButtons.forEach { $0.setTitle("Start", for: .normal) }
        taskLabel.text = "One more try??"
        view.backgroundColor = StyleManager.defaultBackground
        setCurrentRoundLabelVisibility(isVisible: false)
        setRoundNumberPickerVisibility(isVisible: true)
    }
    
    func setRoundNumberPickerVisibility(isVisible: Bool) {
        setRoundsLabel.isHidden = !isVisible
        roundsCountPicker.isHidden = !isVisible
    }
    
    func setCurrentRoundLabelVisibility(isVisible: Bool) {
        currentRoundLabel.isHidden = !isVisible
    }
}

// MARK: - UIPickerViewDataSource + UIPickerViewDelegate

extension GameViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        roundsNumberRange.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(roundsNumberRange[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let roundsNumber = roundsNumberRange[row]
        game.setRoundsCount(with: roundsNumber)
        gameProgress.totalUnitCount = Int64(roundsNumber)
    }
}
