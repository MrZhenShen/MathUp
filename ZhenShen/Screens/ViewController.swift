//
//  ViewController.swift
//  ZhenShen
//
//  Created by abb on 11.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bg: UIView!
    
    @IBOutlet weak var task: UILabel!

    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
//    var btnsUI: [UIButton] { return [btn0, btn1, btn2, btn3] }
    @IBOutlet var btnsUI: [UIButton]!
    
    @IBOutlet weak var labelSetRounds: UILabel!
    @IBOutlet weak var roundNumText: UILabel!
    @IBOutlet weak var pickerNumRounds: UIPickerView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var arrRounds = Array(5...100)
    
    var correctBtnAnswerReserve: Int!
    
    var progressGame = Progress(totalUnitCount: 0)
    
    func play(_ btnNum: Int){
        _ = Game(firstNum: setTaskNum(), secondNum: setTaskNum(), btnSet: [generateRandAnswer(), generateRandAnswer(), generateRandAnswer(), generateRandAnswer()], correctBtnAnswer:setBtnWithCorrectAnswer())
        if (Game.currentRound < Game.roundsAmount) {
            showExample(num1:Game.firstNum, num2:Game.secondNum, "+")
            
            if(Game.currentRound == 0){
                bg.backgroundColor = UIColor.white
            }
            else if(btnNum == correctBtnAnswerReserve){
                bg.backgroundColor = UIColor(red: 175.0/255, green: 252.0/255, blue: 65.0/255, alpha: 1.0)
            }
            else{
                bg.backgroundColor = UIColor(red: 218.0/255, green: 62.0/255, blue: 82.0/255, alpha: 1.0)
            }

            for i in 0...(Game.btnValueSet.count-1) {
                btnsUI[i].setTitle(String(Game.btnValueSet[i]), for: .normal)
            }
            btnsUI[Game.correctBtnAnswer].setTitle(String(Game.correctAnswer), for: .normal)
            Game.btnValueSet[Game.correctBtnAnswer] = Game.correctAnswer
            
            correctBtnAnswerReserve = Game.correctBtnAnswer
            
            showCurrentRoundNumber(false)
            showSetterRoundAmount(true)
            
            Game.currentRound += 1
            roundNumText.text = String(Game.currentRound)
        }
        else{
            resetScene()
            showCurrentRoundNumber(true)
            showSetterRoundAmount(false)
        }
        self.progressGame.completedUnitCount = Int64(Game.currentRound)
        self.progressView.setProgress(Float(self.progressGame.fractionCompleted), animated: true)
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerNumRounds.dataSource = self
        pickerNumRounds.delegate = self
        addShadowToBtn(btns: btnsUI)
    }
}

// MARK: - Protocols

protocol GameComplexity: class { // GameComplexityManager
    func setTaskNum() -> Int
    func generateRandAnswer() -> Int
    func setBtnWithCorrectAnswer() -> Int
}

protocol GamePlay {
//    func button1(_ sender: Any)
//    func button2(_ sender: Any)
//    func button3(_ sender: Any)
//    func button4(_ sender: Any)
    
    func getAnswer(_ sender: UIButton)
}

// MARK: - Extentions
    
extension ViewController{
    func addShadowToBtn(btns: [UIButton]){
        for btn in btns{
            btn.layer.cornerRadius = 5.0
            //button.layer.masksToBounds = true
            btn.layer.shadowColor = UIColor.black.cgColor
            btn.layer.shadowRadius = 2
            btn.layer.shadowOffset = CGSize(width: 2, height: 2)
            btn.layer.shadowOpacity = 0.3
        }
    }
}
extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrRounds.count
    }
}
extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Game.roundsAmount = arrRounds[row]
        progressGame = Progress(totalUnitCount: Int64(Game.roundsAmount))
        return String(arrRounds[row])
    }
}

extension ViewController: GameComplexity{
    func setTaskNum() -> Int{ // generate number, which will be used for calculation in example
        return Int.random(in: 1..<50)
    }
    func generateRandAnswer() -> Int{ // generate number that will be used for gameplay, not answer
        return Int.random(in: 1..<100)
    }
    func setBtnWithCorrectAnswer() -> Int{ // generate number that will be used for gameplay, not answer
        return Int.random(in: 0..<3)
    }
}
extension ViewController{
    func resetScene(){
        for btn in btnsUI { btn.setTitle("Start", for: .normal) }
        showExample("One more try??")
        Game.currentRound = 0
        self.view.backgroundColor = UIColor.white
    }
    func showExample(_ title: String){
        task.text = title
    }
    func showExample(num1: Int, num2: Int, _ action: String){
        task.text = "\(num1) \(action) \(num2)"
    }
    func showSetterRoundAmount(_ stater: Bool){
        labelSetRounds.isHidden = stater
        pickerNumRounds.isHidden = stater
    }
    func showCurrentRoundNumber(_ stater: Bool){
        roundNumText.isHidden = stater
    }
}
extension ViewController: GamePlay{
    @IBAction func getAnswer(_ sender: UIButton) {
        play(sender.tag)
    }

    
//    @IBAction func button1(_ sender: Any) { play(0) }
//    @IBAction func button2(_ sender: Any) { play(1) }
//    @IBAction func button3(_ sender: Any) { play(2) }
//    @IBAction func button4(_ sender: Any) { play(3) }
}
