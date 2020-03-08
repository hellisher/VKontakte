import UIKit
import RealmSwift

class MyFriendsController: UITableViewController {
    
    var friends: Results<Friend>?
    var requestVKAPI = GetVKAPI()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async {
            self.requestVKAPI.loadUserFriendsData() { [weak self] result in
                guard self != nil else { return }
                switch result {
                case .success(let friends):
                    RealmDatabase.shared.saveUserFriendsData(friends)
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        token = RealmDatabase.shared.changesInTheFriendsData(observationHandler: { [weak self] changes in
            switch changes {
            case .error(let error):
                print(error)
            case .initial(let initialFriends):
                self?.friends = initialFriends.sorted(byKeyPath: "id")
                self?.tableView.reloadData()
            case let .update(updatedFriends, _, _, _):
                self?.friends = updatedFriends.sorted(byKeyPath: "id")
                self?.tableView.reloadData()
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        token?.invalidate()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendCell", for: indexPath) as! MyFriendsCell
        guard let friend = friends?[indexPath.row] else {return cell}
        cell.configure(with: friend)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyFriendsPhotoViewController") as! MyFriendsPhotoViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
