import UIKit

class ui_TableViewCell: UITableViewCell
{
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var hpProgressBar: UIProgressView!
    @IBOutlet var strProgressBar: UIProgressView!
    @IBOutlet var weakProgressBar: UIProgressView!
    
    @IBOutlet private var star_1: UIImageView!
    @IBOutlet private var star_2: UIImageView!
    @IBOutlet private var star_3: UIImageView!
    @IBOutlet private var star_4: UIImageView!
    @IBOutlet private var star_5: UIImageView!
 
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    
    typealias CornerBtnAction = () -> Void
    var cornerBtnAction: CornerBtnAction?
    @IBAction private func cornerBtnTriggered(_ sender: UIButton) {   cornerBtnAction?()   }
    func setActionAppearance(isAddOrDelete: Bool)
    {
        addBtn.isHidden = !isAddOrDelete
        deleteBtn.isHidden = isAddOrDelete
    }
    
    func setRarityStars(_ x: Int)
    {
        for (i, star) in [star_1!, star_2!, star_3!, star_4!, star_5!].enumerated()
        {
            star.isHidden = i >= x
        }
    }
}
