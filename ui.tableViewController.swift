import UIKit

class ui_TableViewController: UITableViewController
{
    var isShowingMyList = false
    var nameFilter: String = ""
    
    private var cardList: [model.Card]
    {
        let cardLists = model.CardLists.shared!
        let cardList = isShowingMyList ? cardLists.cardsInMyList : cardLists.cardsNotInMyList
        
        if nameFilter.isEmpty {   return cardList   }
        else
        {   
            return cardList.filter {   $0.name.starts(with: nameFilter)   } 
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let _ = model.CardLists.shared else {   return 0   }
        return cardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell 
        = tableView.dequeueReusableCell(withIdentifier: "ui_TableViewCell", for: indexPath) as? ui_TableViewCell else
        {
            fatalError("Unable to dequeue tableViewCell")
        }
        
        let cardLists = model.CardLists.shared!
        let cardList = self.cardList 
        let card = cardList[indexPath.row]
        cell.nameLabel.text = card.name
        cell.cornerBtnAction =  {   [weak self]
        in
            if self?.isShowingMyList ?? true {   cardLists.removeFromMyList(id: card.id)   }
            else {   cardLists.addToMyList(id: card.id)   }
            
            self?.tableView.reloadData()
        }
        cell.setActionAppearance(isAddOrDelete: !isShowingMyList)
        cell.setRarityStars(card.rarity)
        cell.hpProgressBar.setProgress(Float(card.hp) / Float(cardLists.hp_max), animated: false)
        cell.strProgressBar.setProgress(Float(card.str) / Float(cardLists.str_max), animated: false)
        cell.weakProgressBar.setProgress(Float(card.weakness) / Float(cardLists.weak_max), animated: false)
        
        return cell
    }
}
