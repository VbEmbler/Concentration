//
//  Card.swift
//  Concentration
//
//  Created by Vladimir on 28/01/2021.
//  Copyright © 2021 Embler. All rights reserved.
//

struct Card {
    
    //MARK: - Public Properties
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    //MARK: - Private Properties
    private static var identifierFactory = 0
    
    //MARK: - Initializers
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    //MARK: - Private Methods
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
