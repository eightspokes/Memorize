// *** Model ***


import Foundation


struct MemoryGame <CardContent: Equatable> {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{ cards.indices.filter({ cards[$0].isFaceUp}).oneAndOnly}
        set{ cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue)}}
    }
    private(set) var theme: Theme
    private(set) var score: Int = 0
    
    // init's second argument is a function that takes some Int and returns CardContent
    init(numberOfPairsOfCards: Int, theme: Theme, createCardContent: (Int) -> CardContent){
        self.theme = theme
        cards = Array<Card>()
        //Add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2 , content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
        
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched  {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2
                }else{
                    score -= 1
                }
                cards[chosenIndex].isFaceUp = true
            }else{
                for index in cards.indices{
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            
            
            print("Current card \(cards[chosenIndex])")
        }else{
            print("No card found")
        }
        
        
    }
    struct Card: Identifiable {
        let id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent  // content never changes 
    }
}


extension Array{
    // If you have a var in an extension, it has to be computed. You can't have a var that is stored.
    var oneAndOnly: Element?{
        if count == 1 {
            return first
        }else{
            return nil
        }
    }
}
