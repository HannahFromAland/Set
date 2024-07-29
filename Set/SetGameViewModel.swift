//
//  SetGameViewModel.swift
//  Set
//
//  Created by HannPC on 2024/7/28.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    let defaultCardNum: Int = 12
    private var cardsNumShown: Int
    @Published private var model: SetGame
    
    private static func createSetGame() -> SetGame {
        return SetGame()
    }
    
    init() {
        cardsNumShown = defaultCardNum
        model = SetGameViewModel.createSetGame()
    }
    
    var cards: Array<Card> {
        if model.cards.count >= cardsNumShown {
            return Array(model.cards[0..<cardsNumShown])
        }
        return model.cards
    }
    
    func getMatchStatus() -> Int {
        return model.matchStatus
    }
    
    // MARK: Intents
    func restart() {
        cardsNumShown = defaultCardNum
        model = SetGameViewModel.createSetGame()
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
