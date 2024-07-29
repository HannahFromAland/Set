//
//  ContentView.swift
//  Set
//
//  Created by HannPC on 2024/7/28.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 10
    
    
    
    var body: some View {
        VStack (spacing: spacing){
            VStack {
                cardTable
                    .animation(.default, value: viewModel.cards)
            }
            .padding()
            HStack{
                Button("New Game") {
                    viewModel.restart()
                }
                Spacer()
                Button("Deal 3 More Cards") {
                    viewModel.shuffle()
                }
            }
            .padding()
        }
    }
    
    private var cardTable: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(viewModel: viewModel, card: card)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
