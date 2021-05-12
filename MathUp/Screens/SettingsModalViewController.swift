//
//  SettingsModalViewController.swift
//  MathUp
//
//  Created by Yevhen Rozhylo on 03.05.2021.
//

import UIKit

class SettingsModalViewController: UIViewController {

// MARK: - IBOutlets
    
    @IBOutlet weak var roundsCountPicker: UIPickerView!
    
// MARK: - Delegates
    
    var roundsNumberDelegate: ApplySettingsDelegate?
    
// MARK: - Model
    
    private var roundsNumberRange: [Int] {
        let roundsMinimalValue = 5
        let roundsMaximalValue = 100
        return Array(roundsMinimalValue...roundsMaximalValue)
    }
    
// MARK: - Live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundsCountPicker.delegate = self
        roundsCountPicker.dataSource = self
    }
    
}

// MARK: - UIPickerViewDataSource + UIPickerViewDelegate

extension SettingsModalViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        roundsNumberDelegate?.setRoundsAmount(roundsNumber)
    }
}
