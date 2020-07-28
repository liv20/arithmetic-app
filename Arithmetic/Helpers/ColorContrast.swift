//
//  ColorContrast.swift
//  Arithmetic
//
//  Created by Victor Li on 7/26/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

class ColorContrast {

    func isLight(cgColor: CGColor, threshold: CGFloat) -> Bool {
        if let c = cgColor.components {
            let red = c[0]
            let green = c[1]
            let blue = c[2]
            let brightness = (0.241*red*red + 0.691*green*green + 0.068*blue*blue).squareRoot()

            if brightness >= threshold {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

}
