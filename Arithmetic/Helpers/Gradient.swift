//
//  Gradient.swift
//  Arithmetic
//
//  Created by Victor Li on 7/26/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import Foundation
import UIKit

struct Gradient {
    var colors : [CGColor]
    init(fromColors : [CGColor]) {
        colors = fromColors
    }

    init(fromInts: [Int]) {
        var c = [CGColor]()
        for i in 0..<fromInts.count {
            c.append(UIColor(hex: fromInts[i]).cgColor)
        }
        colors = c
    }
}

let colorIntegers : [[Int]] = [
    [0x50d890, 0x127681], [pink, purple], [0x6284FF, 0xFF0000],
    [0xFEE140, 0xFA709A], [0x21D4FD, 0xB721FF], [0xFBAB7E, 0xF7CE68],
    [0x08AEEA, 0x2AF598], [0xFAACA8, 0xDDD6F3], [0xFF3CAC, 0x784BA0],
    [0xD9AFD9, 0x97D9E1], [0x00DBDE, 0xFC00FF], [0x7fdbda, 0xe8505b],
    [0xffe0f7, 0xfe91ca], [0xc7b198, 0xf0ece3], [0x0fabbc, 0xfecb89],
    [0xe36387, 0xe7305b], [0xfb7813, 0x17706e], [0x1943ab, 0xcfa328]
]

let grad0 = Gradient(fromInts: colorIntegers[0]).colors
let grad1 = Gradient(fromInts: colorIntegers[1]).colors
let grad2 = Gradient(fromInts: colorIntegers[2]).colors
let grad3 = Gradient(fromInts: colorIntegers[3]).colors
let grad4 = Gradient(fromInts: colorIntegers[4]).colors
let grad5 = Gradient(fromInts: colorIntegers[5]).colors
let grad6 = Gradient(fromInts: colorIntegers[6]).colors
let grad7 = Gradient(fromInts: colorIntegers[7]).colors
let grad8 = Gradient(fromInts: colorIntegers[8]).colors
let grad9 = Gradient(fromInts: colorIntegers[9]).colors
let grad10 = Gradient(fromInts: colorIntegers[10]).colors
let grad11 = Gradient(fromInts: colorIntegers[11]).colors
let grad12 = Gradient(fromInts: colorIntegers[12]).colors
let grad13 = Gradient(fromInts: colorIntegers[13]).colors
let grad14 = Gradient(fromInts: colorIntegers[14]).colors
let grad15 = Gradient(fromInts: colorIntegers[15]).colors
let grad16 = Gradient(fromInts: colorIntegers[16]).colors
let grad17 = Gradient(fromInts: colorIntegers[17]).colors

let gradients: [[CGColor]] = [grad0, grad1, grad2, grad3, grad4, grad5, grad6, grad7, grad8, grad9, grad10, grad11, grad12, grad13, grad14, grad15, grad16, grad17]
