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
            HStack {
                Text("Set!")
                    .font(.system(size: 50, design: .serif))
                    .italic()
                    .padding()
                    
            }
            if (viewModel.cards.count == 3 &&
                viewModel.getMatchStatus() == 1) {
                // display finish page
                VStack {
                    Spacer()
                    Text("Success!")
                        .font(.system(size: 70, design: .serif))
                        .italic()
                        .foregroundStyle(.indigo)
                    Spacer()
                }
                .padding()
                HStack{
                    Spacer()
                    Button("New Game") {
                        viewModel.restart()
                    }
                    Spacer()
                }
                .foregroundColor(.black)
                .font(.system(size: 20, design: .serif))
                .padding()
            } else {
                cardTable
                    .animation(.default, value: viewModel.cards)
                    .padding()
                HStack{
                    Button("New Game") {
                        viewModel.restart()
                    }
                    Spacer()
                    Button("Deal 3 More Cards") {
                        viewModel.dealThreeMore()
                    }
                }
                .foregroundColor(.black)
                .font(.system(size: 20, design: .serif))
                .padding()
            }

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
