//
//  GameViewController.swift
//  ZhenShen
//
//  Created by abb on 11.02.2021.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Delegates
    
    var roundsDataDelegate: StatisticViewControllerDelegate?

    // MARK: - Outlets
    
    @IBOutlet private var answerButtons: [UIButton]!
    @IBOutlet private var taskLabel: UILabel!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var currentRoundLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!

    // MARK: - Model
    
    private let game = Game()
    private var gameProgress = Progress(totalUnitCount: 0)
    private var roundsDataArray: [GameRoundData] = []
    
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
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func setInitialRoundsNumber() {
        if let minimalRoundsNumber = roundsNumberRange.first {
            game.setRoundsCount(with: minimalRoundsNumber)
            gameProgress.totalUnitCount = Int64(minimalRoundsNumber)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettings" {
            if let settingsModalViewController = segue.destination as? SettingsModalViewController {
                settingsModalViewController.roundsNumberDelegate = self
            }
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
            game.updateRoundsData(for: index)
            
            startNextRound()

        case .finished:
            // TODO: Would be really nice to show user result here
            game.updateRoundsData(for: index)
            roundsDataDelegate?.sendRoundsDataToTableViewController(game.getRoundsData())
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
        setSettingsIconVisibility(isVisible: false)
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
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)

        let largeBoldDoc = UIImage(systemName: "gearshape", withConfiguration: largeConfig)

        settingsButton.setImage(largeBoldDoc, for: .normal)
    }
    
    func resetScene() {
        answerButtons.forEach { $0.setTitle("Start", for: .normal) }
        taskLabel.text = "One more try??"
        view.backgroundColor = StyleManager.defaultBackground
        setCurrentRoundLabelVisibility(isVisible: false)
        setSettingsIconVisibility(isVisible: true)
    }
    
    func setCurrentRoundLabelVisibility(isVisible: Bool) {
        currentRoundLabel.isHidden = !isVisible
    }
    
    func setSettingsIconVisibility(isVisible: Bool) {
        settingsButton.isHidden = !isVisible
    }
}

// MARK: - Statistics View Controller Delegate

extension GameViewController: StatisticViewControllerDelegate {
    
    func sendRoundsDataToTableViewController(_ data: [GameRoundData]) {}

    func clearRoundsData() {
        game.clearRoundsData()
    }
}

// MARK: - Modal View Controller Delegate

extension GameViewController: ApplySettingsDelegate{
    func setRoundsAmount(_ quantityRounds: Int) {
        
        game.setRoundsCount(with: quantityRounds)
        gameProgress.totalUnitCount = Int64(quantityRounds)
    }
}

