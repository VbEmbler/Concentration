//
//  Concentration.swift
//  Concentration
//
//  Created by Vladimir on 28/01/2021.
//  Copyright © 2021 Embler. All rights reserved.
//

import Foundation

class Concentration {
    
    //MARK: - Public Properties
    var cards: [Card] = []
    var indexOfOneAndOnlyOneFaceUpCard: Int?
    
    //MARK: - Initializers
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: shuffle the cards
    }
    
    //MARK: - Public Methods
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
    }
}
