//
//  SetGame.swift
//  Set
//
//  Created by HannPC on 2024/7/28.
//

import Foundation
import SwiftUI

struct SetGame {
    private(set) var cards: Array<Card>
    private(set) var selection: Array<Card> = []
    // using a flag to quickly determine the status of the set
    // 0 in progress
    // 1 matched
    // 2 not matched
    private(set) var matchStatus: Int = 0
    
    
    init() {
        cards = []
        let colors: Array<Color> = [.purple,.mint, .pink]
        var cardId: Int = 0
        for color in colors {
            for number in 1...3 {
                for shape in ContentShape.allCases {
                    for style in ShadingStyle.allCases {
                        let content: CardContent = CardContent(shape: shape, color: color, number: number, shading: style)
                        cards.append(Card(content: content, id: cardId))
                        cardId += 1
                    }
                }
            }
        }
//        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if selection.count == 3 {
                // no-op when there are three cards being selected and still choose among these three cards
                for selected in selection {
                    if selected.id == cards[chosenIndex].id {
                        return
                    }
                }
                print("three=== \(selection)")
                updateStatus()
                // check if previous three cards are a matching
                if checkSetIfMatching() {
                    // remove the matched three cards from the card array
                    print("matched, removing ---")
                    for selected in selection {
                        for index in cards.indices {
                            if(cards[index].id == selected.id) {
                                cards.remove(at: index)
                                break
                            }
                        }
                    }
                } else {
                    print("not matched, removing ---")
                    // three existing selection is not a matching
                    for selected in selection {
                        for index in cards.indices {
                            if(cards[index].id == selected.id) {
                                cards[index].isChosen = false
                            }
                        }
                    }
                }
                // reset selection array to be empty
                selection = []
                updateStatus()
            } else {
                // selection cards less than three
                // first check if cards was already been chosen, if yes then de-select
                if cards[chosenIndex].isChosen {
                    if let currIndexChosen = selection.firstIndex(where: {$0.id == card.id}) {
                        selection.remove(at: currIndexChosen)
                    }
                } else {
                    selection.append(cards[chosenIndex])
                }
                cards[chosenIndex].isChosen = !cards[chosenIndex].isChosen
                updateStatus()
            }
        }
    }
    
    mutating func updateStatus() {
        if selection.count == 3 {
            if checkSetIfMatching() {
                matchStatus = 1
            } else {
                matchStatus = 2
            }
        } else {
            matchStatus = 0
        }
    }
    
    func checkSetIfMatching() -> Bool {
        let shapeMatch: Bool = checkMatching(
            selection[0].content.shape,
            selection[1].content.shape,
            selection[2].content.shape
        )
        let colorMatch: Bool = checkMatching(
            selection[0].content.color,
            selection[1].content.color,
            selection[2].content.color
        )
        let numberMatch: Bool = checkMatching(
            selection[0].content.number,
            selection[1].content.number,
            selection[2].content.number
        )
        let styleMatch: Bool = checkMatching(
            selection[0].content.shading,
            selection[1].content.shading,
            selection[2].content.shading
        )
        return shapeMatch && colorMatch && numberMatch && styleMatch
    }
    
    // check if three properties are either all equals or none of them are identical
    func checkMatching<Property: Equatable>(_ a: Property, _ b: Property, _ c: Property) -> Bool {
        return (a == b && b == c) || (a != b && b != c && c != a)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        var content: CardContent
        var isChosen: Bool = false
        
        var id: Int
        var debugDescription: String {
            return "\(id): \(content) is \(isChosen ? "true" : "false");"
        }
    }
    
    struct CardContent: Equatable {
        var shape: ContentShape
        var color: Color
        var number: Int
        var shading: ShadingStyle
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
}

enum ContentShape: CaseIterable {
    case diamond, squiggle, oval
}

enum ShadingStyle: CaseIterable {
    case solid, striped, open
}
