//
//  TaskInfoTableViewCell.swift
//  MathUp
//
//  Created by Yevhen Rozhylo on 17.04.2021.
//

import UIKit

class TaskInfoTableViewCell: UITableViewCell {
    
    static let cellID = "TaskInfoTableViewCell"
    
// MARK: - Cell Component Outlets
    
    @IBOutlet weak var roundNumberLabel: UILabel!
    @IBOutlet weak var userAnswerLabel: UILabel!
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var timeSpentForTaskLabel: UILabel!
    
    @IBOutlet weak var backgroundCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
