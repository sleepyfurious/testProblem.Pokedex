import Foundation

extension model
{
    struct Card
    {
        typealias Id = String
    
        var id: Id
        var name: String
        var image: URL
        var hp: Int
        var str: Int
        var weakness: Int
        var rarity: Int
    }
}
