// *** View Model ***

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: (MemoryGame<String>,Theme) = createMemoryGame()
    public var theme: Theme {
        return model.1

    }
    public var color: Color{
        return EmojiMemoryGame.interpretColor(color: model.1.color)
    }
    
    public var emojis: ArraySlice<String>{
        let emojisShuffled = model.1.emojis.shuffled()
        return emojisShuffled[0..<model.1.numberOfPairs]
    }
    public var score: Int{
        return model.0.score
    }
   
    
    enum ColorChoice: String  {
        case green = "green"
        case blue = "blue"
        case yellow = "yellow"
        case red = "red"
        case purple = "purple"
        case pink = "pink"
        case indigo = "indigo"
        case cyan = "cyan"
        case brown = "brown"
    }
    
    private static func interpretColor(color: String) -> Color{
        switch color {
            
        case ColorChoice.green.rawValue:
            return Color.green
        case ColorChoice.blue.rawValue:
            return Color.blue
        case ColorChoice.yellow.rawValue:
            return Color.yellow
        case ColorChoice.red.rawValue:
            return Color.red
        case ColorChoice.purple.rawValue:
            return Color.purple
        case ColorChoice.pink.rawValue:
            return Color.pink
        case ColorChoice.indigo.rawValue:
            return Color.indigo
        case ColorChoice.cyan.rawValue:
            return Color.cyan
        case ColorChoice.brown.rawValue:
            return Color.brown
        default:
            return Color.blue
        }
    }
    typealias Card = MemoryGame<String>.Card
    
    //Global constant but its name included EmojiMemoryGame
    static let emojis = ["🚑","🚌","🚁","🚙","🚎","🚜","🦽","🚛","🏍","🛺","🚲","🚔","🚠"]
    static let modelTheme = [
        Theme(name: "Vehicles", numberOfPairs: 13, color: "red", emojis: ["🚑","🚌","🚁","🚙","🚎","🚜","🦽","🚛","🏍","🛺","🚲","🚔","🚠"]),
        Theme(name: "Animals", numberOfPairs: 10, color: "blue", emojis: ["🐸", "🐼","🐔","🐷","🦁","🦇","🐤","🐂","🦒","🦩","🐫"]),
        Theme(name: "Veggies", numberOfPairs: 15, color: "pink", emojis: ["🍋","🍒","🍎","🍉","🥕","🥑","🥦","🍠","🍅","🥯","🍏","🍔","🍟","🌭","🫐","🍌","🥥","🍆","🥝","🥬"])
    ]
    
    static func createMemoryGame() -> (MemoryGame<String>, Theme) {
        
        // In separates the function from the code that has been executed
       
        let theme: Theme = modelTheme.randomElement()!
        let game = MemoryGame<String>(numberOfPairsOfCards: 5, theme: theme) { index  in
            return theme.emojis[index] }
            
            return (game, theme)
            
    }
    
    
     func resetMemoryGame(){
        self.model = EmojiMemoryGame.createMemoryGame()
    }
        
        var cards: Array<EmojiMemoryGame.Card>   {
            return model.0.cards
        }
        
        // MARK: - Intent(a)
        func choose(_ card: MemoryGame<String>.Card){
            model.0.choose(card)
        }
    }

