import UIKit
import RealmSwift

class NewsViewController: UITableViewController {
    
    var news = try? Realm().objects(News.self)
    var requestVKAPI = GetVKAPI()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        token = RealmDatabase.shared.changesInTheNewsData()
        
        DispatchQueue.global().async {
            self.requestVKAPI.loadUserNews{[weak self] result in
                guard self != nil else { return }
                switch result {
                case .success(let news, _, _):
                    RealmDatabase.shared.saveUserNews(news)
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        guard let news = news?[indexPath.row] else {return cell}
        cell.configure(with: news)
        return cell
    }
}
