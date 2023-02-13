//
//  ContentView.swift
//  Memorize
//
//  Created by Roman on 12/27/22.
//

import SwiftUI

struct CardView: View{
    
    var color : Color
    var card : EmojiMemoryGame.Card
    var body: some View{
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
        
        GeometryReader(content: {geometry in
            ZStack {
                if card.isFaceUp{
                    shape
                        .fill(.white)
                    shape
                        .strokeBorder(lineWidth: DrawingConstants.strokeBorderWidth)
                        .foregroundColor(color)
                    
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 180))
                        .padding(5)
                        .foregroundColor(color)
                        .opacity(0.5)
                    Text(card.content)
                        .font(Font.system(size: min(geometry.size.width, geometry.size.height)*DrawingConstants.pictureScalingFactor))
                }else if card.isMatched{
                    shape.opacity(0)
                }else{
                    shape.fill(color)
                }
            }
        })
    }
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let strokeBorderWidth: CGFloat = 3
        static let pictureScalingFactor: CGFloat = 0.7
    }
    
}

struct EmojiMemoryGameView: View {
    @ObservedObject var game : EmojiMemoryGame
    @State var emojis = ["vehicles":["🚑","🚌","🚁","🚙","🚎","🚜","🦽","🚛","🏍","🛺","🚲","🚔","🚠"], "animals": ["🐸", "🐼","🐔","🐷","🦁","🦇","🐤","🐂","🦒","🦩","🐫"],"food": ["🍋","🍒","🍎","🍉","🥕","🥑","🥦","🍠","🍅","🥯","🍏","🍔","🍟","🌭","🫐","🍌","🥥","🍆","🥝","🥬"] ]
    @State private var selectedTheme = "vehicles"
    var body: some View {
        NavigationView{

            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: {
                card in
                
                CardView(color: game.color, card: card ).aspectRatio( 2/3, contentMode: .fit)
                            .padding(2)
                            .onTapGesture{game.choose(card)}
            })
            .padding(.horizontal)
            .navigationTitle("Memory Game")
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar){
                    HStack{
                        Text("Theme: \(game.theme.name)")
                            .font(.title3.bold())
                          
                        Spacer()
                        Text("Score: \(game.score)")
                            .font(.title3.bold())
                        Spacer()
                        Button(action:{
                            game.resetMemoryGame()
                        }, label: {
                            Image(systemName: "play")
                        })
                    }
                    .padding(.horizontal)
                    
                }
                }
            .onChange(of: selectedTheme){ _ in
                shuffleEmojiArray()
            }
        }}
    

    func shuffleEmojiArray(){
        if let emojisTemp = emojis[selectedTheme]{
            emojis[selectedTheme] = emojisTemp.shuffled()
        }
        print("Could not unwrap emojis")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
          
    }
}
