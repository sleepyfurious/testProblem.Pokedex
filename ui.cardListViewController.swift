import UIKit

class ui_CardListViewController: UIViewController
{
    override func viewWillDisappear(_ animated: Bool)
    {
        ui_ViewController.tableVC.tableView.reloadData()
    }
}
