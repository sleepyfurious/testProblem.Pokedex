import XCTest
@testable import Pokedex

class model_CardList_Fetcher_Tests: XCTestCase
{
    func test_fetch_return_some_card()
    {        
        let synch = XCTestExpectation()
        
        Pokedex.model.CardLists.fetch {   result
        in
            if case .success(let value) = result
            { 
                XCTAssertGreaterThan(value.cardsNotInMyList.count, 0)
                synch.fulfill()
            }
            else {   XCTFail()   }
        }
        
        wait(for:[synch], timeout: 10)
    }
}
