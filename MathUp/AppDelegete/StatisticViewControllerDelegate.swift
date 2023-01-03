//
//  StatisticViewControllerDelegate.swift
//  MathUp
//
//  Created by Yevhen Rozhylo on 20.04.2021.
//

import Foundation

protocol StatisticViewControllerDelegate: class {
    func sendRoundsDataToTableViewController(_ data: [GameRoundData])
    func clearRoundsData()
}
