import UIKit
import RealmSwift

class NewsViewController: UITableViewController {
    
    var news = try? Realm().objects(News.self)
    var requestVKAPI = GetVKAPI()
    var token: NotificationToken?
    
    @objc func refreshNews() {
        self.refreshControl?.beginRefreshing()
        let mostFreshNewDate = self.news?.first?.date ?? Date().timeIntervalSince1970
        
        requestVKAPI.loadUserNews(startTime: mostFreshNewDate + 1) { [weak self] news in
            
            guard self != nil else { return }
            
            switch news {
            case .success(let news, _, _):
                RealmDatabase.shared.saveUserNews(news)
                self.refreshControl?.endRefreshing()
                guard news.count > 0 else { return }
                self.news = news + self.news
                let indexSet = IndexSet(integerIn: 0..<news.count)
                self.tableView.insertSections(IndexSet, with: .automatic)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            self?.refreshControl?.endRefreshing()
        }
    }
    
    fileprivate func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Ёпта! Обновляется!")
        refreshControl?.tintColor = .magenta
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        
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
