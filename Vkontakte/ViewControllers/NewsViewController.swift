import UIKit

class NewsViewController: UITableViewController {
    
    var news = [News]()
    var requestToServer = GetVKAPI()
//    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        requestToServer.loadUserNews{[weak self] result in
            guard let self = self else { return }
//            switch result {
//            case .success(let news):
//                RealmDatabase.save(items: news)
//            case .failure(let error):
//                fatalError(error.localizedDescription)
//            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
}
