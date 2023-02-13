//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Roman on 12/27/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // let still allows us to change game because game is a pointer.
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
