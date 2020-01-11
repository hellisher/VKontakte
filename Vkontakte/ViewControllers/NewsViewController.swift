import UIKit
import RealmSwift

class NewsViewController: UITableViewController {
    
    var news = [News]()
    var requestVKAPI = GetVKAPI()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = RealmDatabase.shared.changesInTheGroupsData()
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        requestVKAPI.loadUserNews{[weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let news):
                RealmDatabase.shared.saveUserNews(news)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
}
