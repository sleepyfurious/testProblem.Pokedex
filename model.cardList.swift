
extension model
{
    /// Managing cards state for this app.
    ///
    class CardLists
    {        
        /// For singleton use in this app.
        /// 
        /// Note that the life cycle of this singleton is not managed here and the initializer is exposed at public level because:
        /// 1. Cards' data needs to be supplied from somewhere else.
        /// 2. Testing a singleton is hard when it can't be reinitialized in test code easily.
        /// 
        /// So, for singleton use, be careful to initialize it once as intended. An instantiation of this class elsewhere is reserved for testing purposes only.
        ///
        static var shared: CardLists!
    
        private let cards: [Card]
        init(cards: [Card]) {   self.cards = cards   }
        
        private var myList: Set<Card.Id> = []
        func addToMyList(id: Card.Id) {   myList.insert(id)   }
        func removeFromMyList(id: Card.Id) {   myList.remove(id)   }
        
        var cardsInMyList: [Card]
        {
            cards.filter {   myList.contains($0.id)   }
        }
        var cardsNotInMyList: [Card]
        {
            cards.filter {   !myList.contains($0.id)   }
        }
    }
}
