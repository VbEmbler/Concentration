//
//  Card.swift
//  Concentration
//
//  Created by Vladimir on 28/01/2021.
//  Copyright © 2021 Embler. All rights reserved.
//

import Foundation

struct Card {
    
    //MARK: - Static Properties
    static var identifierFactory = 0
    
    //MARK: - Public Properties
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    //MARK: - Initializers
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    //MARK: - Static Methods
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
