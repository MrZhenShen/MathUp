//
//  TabBarViewController.swift
//  MathUp
//
//  Created by Yevhen Rozhylo on 22.04.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

// MARK: -  View Controllers
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let gameController = storyboard.instantiateViewController(identifier: "GameViewController") as! GameViewController
        let statisticController = storyboard.instantiateViewController(identifier: "StatisticViewController") as! StatisticViewController

// MARK: - Tab Bars Items
        
        let iconGame = UITabBarItem(title: "Game", image: StyleManager.gameTabBarImage, tag: 0)
        let iconStatistic = UITabBarItem(title: "Statistics", image: StyleManager.statisticTabBarImage, tag: 1)
        
        gameController.tabBarItem = iconGame
        statisticController.tabBarItem = iconStatistic
        
// MARK: - Set Delegates
        
        gameController.roundsDataDelegate = statisticController
        statisticController.clearRoundsDataDelegate = gameController
        
// MARK: - Set View Controllers in Storyboard
        self.viewControllers = [gameController, statisticController]
    }
    
}
