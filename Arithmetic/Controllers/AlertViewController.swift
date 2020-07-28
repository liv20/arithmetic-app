//
//  AlertViewController.swift
//  Arithmetic
//
//  Created by Victor Li on 7/26/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!

    @IBOutlet weak var actionButton: UIButton!

    var alertTitle = String()
    var alertBody = String()
    var actionButtonTitle = String()
    var buttonAction: (() -> Void)?

    let gradient = gradients[UserDefaults.standard.integer(forKey: "GradientPosition")]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        backgroundView.layer.cornerRadius = 20
        actionButton.layer.cornerRadius = 10
        noButton.layer.cornerRadius = 10

        titleView.backgroundColor = UIColor(cgColor: gradient[0])
        backgroundView.backgroundColor = UIColor(cgColor: gradient[1])

        actionButton.setTitleColor(UIColor(cgColor: gradient[0]), for: .normal)
        noButton.setTitleColor(UIColor(cgColor: gradient[1]), for: .normal)
    }

    func setupView() {
        titleLabel.text = alertTitle
        messageLabel.text = alertBody
        actionButton.setTitle(actionButtonTitle, for: .normal)
    }

    @IBAction func actionButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
        buttonAction?()
    }

    @IBAction func noButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    



}
