//
//  AlertService.swift
//  Arithmetic
//
//  Created by Victor Li on 7/26/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

class AlertService {
    func alert(title: String, body: String, buttonTitle: String, completion: @escaping () -> Void) -> AlertViewController {
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)

        let alertVC = storyboard.instantiateViewController(identifier: "AlertVC") as! AlertViewController

        alertVC.alertTitle = title
        alertVC.alertBody = body
        alertVC.actionButtonTitle = buttonTitle
        alertVC.buttonAction = completion

        return alertVC
    }
}
