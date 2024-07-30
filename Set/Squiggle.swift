//
//  Squiggle.swift
//  Set
//
//  Created by HannPC on 2024/7/29.
//

import SwiftUI
import CoreGraphics

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()
            

        path.move(to: CGPoint(x: 0, y: rect.midY / 2))
        
        let waveRatio: CGFloat = rect.height / 10
        
        for x in stride(from:0, through: rect.width, by: 1) {
            let y = sin(x / rect.width * .pi * 2) * waveRatio +  rect.midY / 2
            path.addLine(to: CGPoint(x:x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.midY/2 * 3))
        
        path.move(to: CGPoint(x: 0, y: rect.midY / 2))
        path.addLine(to: CGPoint(x: 0, y: rect.midY/2 * 3))
        
        for x in stride(from:0, through: rect.width, by: 1) {
            let y = sin(x / rect.width * .pi * 2) * waveRatio + rect.midY / 2 * 3
            path.addLine(to: CGPoint(x:x, y: y))
        }
        
        return path
        }
}
