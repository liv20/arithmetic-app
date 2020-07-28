//
//  GradientCollectionViewCell.swift
//  Arithmetic
//
//  Created by Victor Li on 7/25/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

class GradientCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gradientView: UIView!
    var colors : [CGColor]? {
        didSet {
            let g = CAGradientLayer()
            g.frame = gradientView.frame
            g.colors = colors
            gradientView.layer.insertSublayer(g, at: 0)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.clear.cgColor
    }

}
