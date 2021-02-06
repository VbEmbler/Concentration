//
//  Int + arc4random.swift
//  Concentration
//
//  Created by Vladimir on 06/02/2021.
//  Copyright © 2021 Embler. All rights reserved.
//

import Foundation

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
