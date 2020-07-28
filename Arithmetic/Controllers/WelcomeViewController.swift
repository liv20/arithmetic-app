//
//  WelcomeViewController.swift
//  Arithmetic
//
//  Created by Victor Li on 7/24/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

class WelcomeViewController: ArithmeticViewController {

    var highScore : Int? {
        didSet {
            highScoreLabel.text = "High Score: \(highScore ?? 0)"
        }
    }

    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        highScore = defaults.integer(forKey: "HighestScore")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)


        playButton.layer.cornerRadius = playButton.frame.height / 2
        settingsButton.layer.cornerRadius = settingsButton.frame.height / 2
        playButton.setTitleColor(UIColor(cgColor: gradientColor[0]), for: .normal)
        settingsButton.setTitleColor(UIColor(cgColor: gradientColor[1]), for: .normal)
    }


    @IBAction func playButtonPressed(_ sender: UIButton) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == welcomeToPlay {
            let destinationVC = segue.destination as! PlayViewController
            destinationVC.playVCDelegate = self
        }
    }


}

extension WelcomeViewController : PlayVCDelegate {

    func playVCDidFinish(withScore score: Int) {
        self.navigationController?.popToRootViewController(animated: true)

        if let safeHighScore = highScore {
            if score > safeHighScore {
                highScore = score
                defaults.set(score, forKey: "HighestScore")
                highScoreLabel.text = "High Score: \(highScore!)"
            }
        }

    }
}
