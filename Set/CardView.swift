//
//  CardView.swift
//  Set
//
//  Created by HannPC on 2024/7/28.
//

import SwiftUI

struct CardView: View {
    typealias Card = SetGame.Card
    @ObservedObject var viewModel: SetGameViewModel
    let card: Card

    
    @ViewBuilder
    func addStyle(_ shape: some Shape, width: CGFloat, height: CGFloat) -> some View {
        switch card.content.shading {
        case .solid:
            shape
                .fill(card.content.color)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .frame(width: width, height: height)
        case .striped:
            Stripes()
                .stroke(card.content.color, lineWidth: Constants.lineWidth)
                .clipShape(shape)
                .frame(width: width, height: height)
                .overlay(shape.stroke(card.content.color, lineWidth: Constants.lineWidth))
        case .open:
            shape
                .stroke(card.content.color, lineWidth: Constants.lineWidth)
                .frame(width: width, height: height)
        }
    }
    
    @ViewBuilder
    func enumerateShape(_ shape: some View) -> some View {
        switch card.content.number {
        case 1:
            VStack {
                shape
            }
        case 2:
            VStack {
                shape
                shape
            }
        case 3:
            VStack {
                shape
                shape
                shape
            }
        default:
            VStack {
                Text("Illegal number of shapes cannot be rendered")
            }
        }
    }
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width * Constants.widthRatio
            let height = geometry.size.height * Constants.heightRatio
            ZStack {
                let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                // add animation style for chosen and matching
                if card.isChosen {
                    if (viewModel.getMatchStatus() == 1) {
                        base.strokeBorder(.green, lineWidth: 4)
                    } else if (viewModel.getMatchStatus() == 2) {
                        base.strokeBorder(.red, lineWidth: 4)
                    } else {
                        base.strokeBorder(.yellow, lineWidth: 4)
                    }
                    
                }
                switch card.content.shape {
                case .diamond:
                    enumerateShape(addStyle(Diamond(), width: width, height: height))
                case .squiggle:
                    enumerateShape(addStyle(RoundedRectangle(cornerRadius: Constants.cornerRadius), width: width, height: height))
                case .oval:
                    enumerateShape(addStyle(Ellipse(), width: width, height: height))
                }
            }
            .padding(Constants.inset)
        }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 6
        static let widthRatio: CGFloat = 1/2
        static let heightRatio: CGFloat = 1/6
    }
    struct Stripes: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            let width = rect.width
            let height = rect.height
            
            for x in stride(from: 0, through: width, by: width/10) {
                p.move(to: CGPoint(x: x, y: 0))
                p.addLine(to: CGPoint(x: x, y: height))
            }
            return p
        }
    }
}

#Preview {
    let mockContent = SetGame.CardContent(shape: ContentShape.squiggle, color: Color.pink, number: 3, shading: ShadingStyle.striped)
    return CardView(viewModel: SetGameViewModel(), card: SetGame.Card(content: mockContent, id: 0))
}
