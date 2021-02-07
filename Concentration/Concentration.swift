//
//  Concentration.swift
//  Concentration
//
//  Created by Vladimir on 28/01/2021.
//  Copyright © 2021 Embler. All rights reserved.
//

import Foundation

class Concentration {
    
    //MARK: - Private Properties
    private(set) var cards: [Card] = []
    private(set) var score = 0
    private(set) var flipCount = 0
    
    private var seenCards: Set<Int> = []
    
    private var indexOfOneAndOnlyOneFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    //MARK: - Initializers
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init\(numberOfPairsOfCards)) : you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    //MARK: - Public Methods
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chossen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    //cards match
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    
                    score += Points.bonus.rawValue
                } else {
                    if seenCards.contains(index) {
                        score += Points.penalazing.rawValue
                    } else {
                        seenCards.insert(index)
                    }
                    if seenCards.contains(matchIndex) {
                        score += Points.penalazing.rawValue
                    } else {
                        seenCards.insert(matchIndex)
                    }
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
        flipCount += 1
    }
    
    func resetGame() {
        flipCount = 0
        score = 0
        seenCards = []
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
    }
    
    //MARK: - Enums
    enum Points: Int {
        case bonus = 2
        case penalazing = -1
    }
}
