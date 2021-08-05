import UIKit

class ui_ViewController: UIViewController
{
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    static var tableVC: ui_TableViewController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchDataIfAbsent()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier
        { 
            case "embededMyList":
                Self.tableVC = (segue.destination as! ui_TableViewController)
                Self.tableVC.isShowingMyList = true
                
            default: break
        }
    }
    
    func fetchDataIfAbsent()
    {
        if model.CardLists.shared != nil 
        {   
            loadingIndicator.isHidden = true
            return   
        }
        
        self.view.isUserInteractionEnabled = false
        
        model.CardLists.fetch /*completionHandler:*/ {   [weak self] (result: model.CardLists.FetchResult) 
        in
            switch result
            {
                case .success(let cardLists): 
                    model.CardLists.shared = cardLists
                    DispatchQueue.main.async {   [weak self]
                    in 
                        self?.view.isUserInteractionEnabled = true   
                        self?.loadingIndicator.isHidden = true
                        Self.tableVC.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {   [weak self] in self?.alertFetchFailureAndCloseApp(error)   }
            }
        }
    }
    
    func alertFetchFailureAndCloseApp(_ error: model.CardLists.FetchResultError)
    {
        let message = """
            Fetch error with the following reason: \(error.localizedDescription).
            Application will now close.
            """
    
        let alert = UIAlertController(title: "Fetch Issue", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default) { _
        in 
            exit(0)
        })
        self.present(alert, animated: true, completion: nil)
    }
}
