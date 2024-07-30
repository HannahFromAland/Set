//
//  SetApp.swift
//  Set
//
//  Created by HannPC on 2024/7/28.
//

import SwiftUI

@main
struct SetApp: App {
    @StateObject var game = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: game)
        }
    }
}
