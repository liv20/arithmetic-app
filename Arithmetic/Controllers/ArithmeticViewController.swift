//
//  ArithmeticViewController.swift
//  Arithmetic
//
//  Created by Victor Li on 7/24/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

class ArithmeticViewController: UIViewController {

    let defaults = UserDefaults.standard

    var originalNumLayers : Int?

    var gradientColor = [CGColor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        originalNumLayers = view.layer.sublayers?.count

    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        setUpBackground()
    }

    func setUpBackground() {
        gradientColor = gradients[defaults.integer(forKey: "GradientPosition")]

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = gradientColor
        gradientLayer.name = "GradientLayer"

        if let safeName = view.layer.sublayers?[0].name {
            if safeName == "GradientLayer" {
                view.layer.replaceSublayer(view.layer.sublayers![0], with: gradientLayer)
            } else {
                view.layer.insertSublayer(gradientLayer, at: 0)
            }
        } else {
            view.layer.insertSublayer(gradientLayer, at: 0)

        }


    }

    /*func setUpBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = gradientColor
        view.layer.insertSublayer(gradientLayer, at: 0)
        //print(view.layer.sublayers?.count)
        if view.layer.sublayers?.count ?? 0 > 0 {
            if let sublayer = view.layer.sublayers?[0] {
                view.layer.replaceSublayer(sublayer, with: gradientLayer)
            } else {
                view.layer.insertSublayer(gradientLayer, at: 0)
            }
        } else {
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
    }*/

}
