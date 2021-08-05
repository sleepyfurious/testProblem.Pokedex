import XCTest
@testable import Pokedex

class model_CardList_Tests: XCTestCase
{
    typealias Card = Pokedex.model.Card
    typealias CardList = Pokedex.model.CardLists

    var fixture: CardList! = nil

    override func setUpWithError() throws
    {
        let getDumpCardWithId = { (id: Card.Id) -> Card
        in
            Card(id: id, name: "", image: URL(fileURLWithPath: ""), hp: 0, str: 0, weakness: 0, rarity: 0)
        }

        fixture = .init(cards: 
        [
            getDumpCardWithId("a"),
            getDumpCardWithId("b"),
            getDumpCardWithId("c")
        ])
    }

    func test_initialially_reports_all_cards_not_in_my_list()
    {
        let allCards = fixture.cardsNotInMyList
        XCTAssertTrue(allCards.contains{   $0.id == "a"   })
        XCTAssertTrue(allCards.contains{   $0.id == "b"   })
        XCTAssertTrue(allCards.contains{   $0.id == "c"   })
    }
    
    func test_initialially_reports_zero_cards_not_in_my_list()
    {
        let noCard = fixture.cardsInMyList
        XCTAssertTrue(noCard.isEmpty)
    }
    
    func test_correctly_reports_when_move_one_card_to_my_list()
    {
        let firstCard = fixture.cardsNotInMyList.first!
        let firstCardId = firstCard.id
        fixture.addToMyList(id: firstCardId)
        
        XCTAssertFalse(fixture.cardsNotInMyList.contains{   $0.id == firstCardId   })
        XCTAssertTrue(fixture.cardsInMyList.contains{   $0.id == firstCardId   })
    }
    
    func test_correctly_reports_when_move_all_cards_to_my_list()
    {
        let allCard_n = fixture.cardsNotInMyList.count
        _ = fixture.cardsNotInMyList.map {   fixture.addToMyList(id: $0.id)   }
        XCTAssertTrue(fixture.cardsNotInMyList.isEmpty)
        XCTAssertEqual(fixture.cardsInMyList.count, allCard_n)
    }
}
