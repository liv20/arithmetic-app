//
//  PlayViewController.swift
//  Arithmetic
//
//  Created by Victor Li on 7/24/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

enum Operation {
    case add
    case subtract
    case multiply
    case divide
}

protocol PlayVCDelegate {
    func playVCDidFinish(withScore score: Int)
}

class PlayViewController: ArithmeticViewController {

    var secondsRemaining = 60
    var timer = Timer()

    var currentScore = 0
    var playVCDelegate : PlayVCDelegate?

    var firstNumber: Int?
    var secondNumber: Int?
    var operation: Operation?

    let alertService = AlertService()

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var timerLabel: UILabel!

    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    @IBOutlet weak var signImage: UIImageView!

    
    @IBOutlet weak var o0: UIButton!
    @IBOutlet weak var o1: UIButton!
    @IBOutlet weak var o2: UIButton!
    @IBOutlet weak var o3: UIButton!
    @IBOutlet weak var o4: UIButton!
    @IBOutlet weak var o5: UIButton!
    @IBOutlet weak var o6: UIButton!
    @IBOutlet weak var o7: UIButton!
    @IBOutlet weak var o8: UIButton!
    @IBOutlet weak var o9: UIButton!
    @IBOutlet weak var oac: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nextProblem()
        answerLabel.textColor = UIColor(cgColor:  gradients[defaults.integer(forKey: "GradientPosition")][0])
        //answerLabel.textColor = UIColor(cgColor: gradientColor[0])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //print("PlayViewController sublayer count: \(view.layer.sublayers?.count)")
        timerLabel.text = "0:\(secondsRemaining)"
        adjustButtonAppearance()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)

        
    }

    func adjustButtonAppearance() {
        let oButtons: [UIButton] = [o1, o2, o3, o0, o4, o5, o6, o7, o8, o9, oac]
        for i in 0..<oButtons.count {
            oButtons[i].layer.cornerRadius = oButtons[i].frame.height / 5
            var color = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0)
            let p : CGFloat = CGFloat(i) / CGFloat(oButtons.count)
            color = color.mix(c1: gradientColor[0], c2: gradientColor[1], percent: p)

            oButtons[i].setTitleColor(UIColor(cgColor: color), for: .normal)
        }
        oac.layer.cornerRadius = o9.frame.height / 5

        oac.layer.borderWidth = 5
        oac.layer.borderColor = UIColor.clear.cgColor
        answerLabel.layer.cornerRadius = answerLabel.frame.height / 5
        answerLabel.layer.borderWidth = 10
        answerLabel.layer.borderColor = UIColor.clear.cgColor
    }

    @objc func update() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            if secondsRemaining < 10 {
                timerLabel.text = "0:0\(secondsRemaining)"
            } else {
                timerLabel.text = "0:\(secondsRemaining)"
            }
        } else {
            print("Done!")
            timer.invalidate()
            finish(withScore: currentScore)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let alertVC = alertService.alert(title: "Exit Game?", body: "Are you sure you want to exit game?", buttonTitle: "Yes") {
            self.finish(withScore: self.currentScore)
        }

        present(alertVC, animated: true)

        
        /*print("back button pressed")

        let alertVC = UIAlertController(title: "Game Paused", message: "Are you sure you want to quit game?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (alertAction) in
            self.finish(withScore: self.currentScore)
        }
        let no = UIAlertAction(title: "No", style: .cancel)

        alertVC.addAction(yes)
        alertVC.addAction(no)

        present(alertVC, animated: true, completion: nil)*/


    }

    @IBAction func numberPressed(_ sender: UIButton) {
        if let title = sender.currentTitle {
            switch title {
            case "AC":
                answerLabel.text = ""
                break
            default:
                let oldAns = answerLabel.text!
                let index = title.index(title.endIndex, offsetBy: -1)
                if oldAns.count < maxDigits {
                    answerLabel.text = oldAns + title[index...]
                } else {
                    highlightView(view: answerLabel, flashed: UIColor.red.cgColor, d: 0.4)
                    highlightView(view: oac, flashed: UIColor(displayP3Red: 255, green: 215, blue: 0, alpha: 1).cgColor, d: 2)
                }
            }
        }
        checkAnswer()
    }

    func checkAnswer() {
        if answerLabel.text == "" {
            return
        } else {
            let answer = Int(answerLabel.text!)!
            if isCorrect(ans: answer) {
                highlightView(view: answerLabel, flashed: UIColor(displayP3Red: 255, green: 215, blue: 0, alpha: 1).cgColor, d: 0.4)
                animateScore()
                nextProblem()
                answerLabel.text = ""
            }
        }
    }

    func animateScore() {
        UIView.animate(withDuration: 0.2, animations: {
            self.scoreLabel.transform = .init(scaleX: 1.5, y: 1.5)
        }) { (finished) in
            self.currentScore += 1
            self.scoreLabel.text = "\(self.currentScore)"
            UIView.animate(withDuration: 0.25) {
                self.scoreLabel.transform = .identity
            }
        }
    }

    func highlightView(view: UIView, flashed: CGColor, d: Double) {
        let animation = CABasicAnimation(keyPath: "borderColor")

        animation.fromValue = view.layer.borderColor
        animation.toValue = flashed
        animation.duration = d
        animation.repeatCount = 1
        view.layer.add(animation, forKey: "borderColor")
        view.layer.borderColor = flashed

        let temp = flashed
        animation.toValue = animation.fromValue
        animation.fromValue = temp
        view.layer.add(animation, forKey: "borderColor")
        view.layer.borderColor = (animation.toValue as! CGColor)
    }


    func isCorrect(ans: Int) -> Bool {
        var correctAnswer = 0
        switch operation {
        case .add:
            correctAnswer = firstNumber! + secondNumber!
        case .subtract:
            correctAnswer = firstNumber! - secondNumber!
        case .multiply:
            correctAnswer = firstNumber! * secondNumber!
        case .divide:
            correctAnswer = firstNumber! / secondNumber!
        default:
            return true
        }

        if ans == correctAnswer {
            return true
        } else {
            return false
        }
    }


    func finish(withScore: Int) {
        playVCDelegate?.playVCDidFinish(withScore: currentScore)
    }

    func nextProblem() {

        let operationNum = Int.random(in: 1...4)
        switch operationNum {
        case 1:
            operation = .add
        case 2:
            operation = .subtract
        case 3:
            operation = .multiply
        case 4:
            operation = .divide
        default:
            operation = .add
        }

        firstNumber = Int.random(in: 1...maxNumber)
        secondNumber = Int.random(in: 1...maxNumber)

        if operation == .subtract {
            firstNumber = firstNumber! + secondNumber!
        } else if operation == .divide {
            firstNumber = firstNumber! * secondNumber!
        }

        updateProblemUI()
    }

    func updateProblemUI() {
        firstNumberLabel.text = "\(firstNumber ?? 1)"
        secondNumberLabel.text = "\(secondNumber ?? 1)"
        switch operation {
        case .add:
            signImage.image = UIImage(systemName: plus)
        case .subtract:
            signImage.image = UIImage(systemName: minus)
        case .multiply:
            signImage.image = UIImage(systemName: times)
        case .divide:
            signImage.image = UIImage(systemName: divide)
        default:
            signImage.image = UIImage(systemName: plus)
        }
    }


}
