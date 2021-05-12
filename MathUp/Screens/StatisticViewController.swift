//
//  StatisticViewController.swift
//  MathUp
//
//  Created by Yevhen Rozhylo on 17.04.2021.
//

import UIKit
import Foundation

class StatisticViewController: UIViewController{
    
    @IBOutlet var statisticTableView: UITableView!
    @IBOutlet weak var clearDataButton: UIBarButtonItem!
    
    var clearRoundsDataDelegate: StatisticViewControllerDelegate?
    
    var currentSegment: Int = 0
    
// MARK: - Data variables
    
    var gameData: [GameRoundData] = [] // data for displaying
    var gameAllData: [GameRoundData] = []
    var gameWinsData: [GameRoundData] = []
    var gameLosesData: [GameRoundData] = []
    
// MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TaskInfoTableViewCell", bundle: nil)
        statisticTableView.register(nib, forCellReuseIdentifier: "TaskInfoTableViewCell")
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshTableView()
        handleSegmentIndex()
        
        if gameData.isEmpty {
            setClearButtonAccessibility(isAvailable: false)
        }
        else {
            setClearButtonAccessibility(isAvailable: true)
        }
    }
    
    private func setupTableView() {
        statisticTableView.delegate = self
        statisticTableView.dataSource = self
    }
    
    private func setDataToTableView(roundsData: [GameRoundData]){
        gameAllData = roundsData
        (gameWinsData, gameLosesData) = divideDataIntoWinsAndLoses(gameAllData)
        
        gameData = roundsData
    }
    func divideDataIntoWinsAndLoses(_ data: [GameRoundData]) -> ([GameRoundData], [GameRoundData]){
        for round in data {
            if round.win == true {
                gameWinsData.append(round)
            }
            else {
                gameLosesData.append(round)
            }
        }
        return (gameWinsData, gameLosesData)
    }
    private func refreshTableView(){
        statisticTableView.reloadDataSavingSelections()
    }
//    func checkEmptyData() -> Bool{
//        gameData.isEmpty
//    }
    
}

// MARK: - Actions

private extension StatisticViewController {
    @IBAction func handleClearPress(_ sender: Any) {
        showAlert()
    }
    func showAlert() {
        let clearRoundsDataAlert = UIAlertController(title: "Do you really want to clear all your results?", message: nil, preferredStyle: .alert)
        
        clearRoundsDataAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in }))
        clearRoundsDataAlert.addAction(UIAlertAction(title: "Clear All", style: .destructive, handler: {action in
            self.clearRoundsData()
            self.refreshTableView()
            self.setClearButtonAccessibility(isAvailable: false)
        }))
        
        present(clearRoundsDataAlert, animated: true)
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        currentSegment = sender.selectedSegmentIndex
        handleSegmentIndex()
    }
    func handleSegmentIndex() {
        switch currentSegment {
        case 0:
            gameData = gameAllData
        case 1:
            gameData = gameWinsData
        case 2:
            gameData = gameLosesData
        default:
            print("Segment index error")
        }
        refreshTableView()
    }
    
}

// MARK: - UI Methods

private extension StatisticViewController {
    func setClearButtonAccessibility(isAvailable: Bool) {
        clearDataButton.isEnabled = isAvailable
    }
}

// MARK: - UITableViewDelegate + UITableViewDataSource

extension StatisticViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = statisticTableView.dequeueReusableCell(withIdentifier: TaskInfoTableViewCell.cellID, for: indexPath) as? TaskInfoTableViewCell else {
            return UITableViewCell()
        }
        
        let roundData = gameData[indexPath.row]
        configure(cell, with: roundData)
        
        return cell
    }
    
    private func configure(_ cell: TaskInfoTableViewCell, with round: GameRoundData) {
        cell.roundNumberLabel.text = String(round.roundNumber)
        cell.userAnswerLabel.text = String(round.userAnswer)
        
        cell.taskLabel.text = String(round.task)
        cell.correctAnswerLabel.text = String(round.correctAnswer)
        cell.timeSpentForTaskLabel.text = String(round.roundTime)
        
        cell.userAnswerLabel.textColor = round.win == true ? StyleManager.successBackground : StyleManager.failureBackground
    }
}

// MARK: - StatisticViewControllerDelegate

extension StatisticViewController: StatisticViewControllerDelegate {

    func sendRoundsDataToTableViewController(_ data: [GameRoundData]) {
        setDataToTableView(roundsData: data)
    }
    
    func clearRoundsData() {
        clearRoundsDataDelegate?.clearRoundsData() // clear data from data Struct
        gameData = []
        gameAllData = [] // clear data localy
        gameLosesData = []
        gameWinsData = []
    }

}

// MARK: - Extentions

extension UITableView {
    /// Reloads a table view without losing track of what was selected.
    func reloadDataSavingSelections() {
        let selectedRows = indexPathsForSelectedRows

        reloadData()

        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}
