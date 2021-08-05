import UIKit

class ui_CardListViewController: UIViewController, UISearchBarDelegate
{
    @IBOutlet private var searchBar: UISearchBar!
    private var tableVC: ui_TableViewController!
    
    override func viewWillDisappear(_ animated: Bool)
    {
        ui_ViewController.tableVC.tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier
        { 
            case "embededNotMyList":
                tableVC = (segue.destination as! ui_TableViewController)
                tableVC.isShowingMyList = false
                
            default: break
        }
    }
    
    // UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        tableVC.nameFilter = searchText
        tableVC.tableView.reloadData()
    }
}
