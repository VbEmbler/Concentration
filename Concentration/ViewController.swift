//
//  ViewController.swift
//  Concentration
//
//  Created by Vladimir on 26/01/2021.
//  Copyright © 2021 Embler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var themeLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    //MARK: - Private Properties
    private var indexTheme = 0
    private var numberOfPairsOfCards: Int {
        (cardButtons.count + 1) / 2
    }
    private var backgroundColor = UIColor.black
    private var cardBackColor = UIColor.orange
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var emoji = [Int: String]()
    private var emojiChoices: [String] = []
    private var emojiThemes: [CardTheme] = [
        CardTheme(theme: "Animals",
                  emojies: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"],
                  backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                  cardBackColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
        CardTheme(theme: "Plants",
                  emojies: ["🌸", "🌼", "🌻", "🌺", "🥀", "🌹", "🌷", "💐", "🌴", "🌲", "☘️", "🌵", "🌿", "🎋"],
                  backgroundColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),
                  cardBackColor: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)),
        CardTheme(theme: "Fruits",
                  emojies: ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🥭", "🥥", "🥝"],
                  backgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
                  cardBackColor: #colorLiteral(red: 0.6642704408, green: 0.6034991806, blue: 0.2679750607, alpha: 1)),
        CardTheme(theme: "Sport",
                  emojies: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🏸", "🏒", "🏑"],
                  backgroundColor: #colorLiteral(red: 0.1578247844, green: 0.1345497118, blue: 0.6642704408, alpha: 1),
                  cardBackColor: #colorLiteral(red: 0.181700678, green: 0.6642704408, blue: 0.629986084, alpha: 1)),
        CardTheme(theme: "Transport",
                  emojies: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜", "🚠"],
                  backgroundColor: #colorLiteral(red: 0.6642704408, green: 0.4307521234, blue: 0.5846789699, alpha: 1),
                  cardBackColor: #colorLiteral(red: 0.02448131313, green: 0.005534197055, blue: 0.6642704408, alpha: 1)),
        CardTheme(theme: "Things",
                  emojies: ["⌚️", "📱", "💻", "🖥", "🖨", "🕹", "💽", "💾", "📼", "📷", "🎥", "☎️", "📺", "⌛️"],
                  backgroundColor: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1),
                  cardBackColor: #colorLiteral(red: 0.5317258883, green: 0.2811609738, blue: 0.2735176694, alpha: 1)),
    ]
    
    //MARK: - Ovveride Methods
    override func viewDidLoad() {
        choiseTheme()
        getEmojies()
        setThemeColors()
        updateViewFromModel()
    }
    
    //MARK: - IB Actions
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func resetGameButton(_ sender: UIButton) {
        game.resetGame()
        choiseTheme()
        setThemeColors()
        getEmojies()
        updateViewFromModel()
    }
    
    //MARK: - Private Methods
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardBackColor
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private func getEmojies() {
        emojiChoices = emojiThemes[indexTheme].emojies
        emoji.removeAll()
    }
    
    private func choiseTheme() {
        indexTheme = emojiThemes.count.arc4random
        backgroundColor = emojiThemes[indexTheme].backgroundColor
        cardBackColor = emojiThemes[indexTheme].cardBackColor
        themeLabel.text = emojiThemes[indexTheme].theme
    }
    
    private func setThemeColors() {
        view.backgroundColor = backgroundColor
        themeLabel.textColor = cardBackColor
        flipCountLabel.textColor = cardBackColor
        scoreLabel.textColor = cardBackColor
        newGameButton.backgroundColor = backgroundColor
        newGameButton.setTitleColor(cardBackColor, for: .normal)
    }
}


