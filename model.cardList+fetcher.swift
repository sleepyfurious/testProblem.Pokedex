import Foundation

extension model.CardLists
{
    // Resolve namespacing.
    typealias CardLists = model.CardLists
    typealias Card = model.Card

    typealias FetchResult = Result<CardLists, FetchResultError>
    enum FetchResultError: Error
    {
        case networkError(Error)
        case invalidData
    }
    
    static func fetch(completionHandler: @escaping (FetchResult)-> Void)
    {
        typealias JSON = [String: Any]
            
        guard let url = URL(string: "https://run.mocky.io/v3/f9916417-f92e-478e-bfbc-c39e43f7c75b")
        else {   fatalError()   }
        
        fetch__low_level(with: url) { low_level_result
        in
            let convertedResult: FetchResult = low_level_result.flatMap { (data: Data) -> FetchResult
            in
                Result<CardLists, Error>()
                {
                    guard
                    let json_root = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let json_cards = json_root["cards"] as? [Any]
                    else {   throw FetchResultError.invalidData  }
                    
                    let cardList: [Card] = try json_cards.map { _json_card
                    in
                        guard
                        let json_card = _json_card as? [String: Any],
                        let id = json_card["id"] as? String,
                        let name = json_card["name"] as? String,
                        let _imageUrl = json_card["imageUrl"] as? String,
                        let imageUrl = URL(string: _imageUrl),
                        let hp = json_card["hp"] as? Int,
                        let rarity = json_card["rarity"] as? Int,
                        let json_attacks = json_card["attacks"] as? [Any],
                        let json_weaknesses = json_card["weaknesses"] as? [Any]  
                        else {   throw FetchResultError.invalidData  }
                        
                        let totalDamage = try json_attacks.reduce(0) { partialResult, x
                        in
                            guard
                            let json_attack = x as? [String: Any],
                            let _damage = json_attack["damage"] as? String,
                            let damage = _damage.isEmpty ? 0 : Int(_damage)
                            else {   throw FetchResultError.invalidData  }
                            
                            return partialResult + damage
                        }
                        
                        let str = totalDamage - json_weaknesses.count
                        let weak = json_weaknesses.count * 10
                                      
                        return Card(id: id, name: name, image: imageUrl, hp: hp, str: str, weakness: weak, rarity: rarity)   
                    }
                    
                    return CardLists(cards: cardList)
                }
                .mapError {   _ in   FetchResultError.invalidData   }
            }

            completionHandler(convertedResult)
        }
    }
    
    private static func fetch__low_level(with url: URL, completionHandler: @escaping (Result<Data, FetchResultError>) -> Void)
    {
        URLSession.shared.dataTask(with: url) /*completionHandler:*/ {   (data, response, error) -> Void
        in  
            let result: Result<Data, FetchResultError>
            = error != nil ? .failure(FetchResultError.networkError(error!)) : .success(data!)
            
            completionHandler(result)
        }
        .resume()
    }
}
