import UIKit
import RealmSwift

class MyFriendsController: UITableViewController {
    
    var friends = try? Realm().objects(Friend.self).sorted(byKeyPath: "id")
    var requestVKAPI = GetVKAPI()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = RealmDatabase.shared.changesInTheFriendsData()
        
        FirebaseAPI.shared.writeUser(name: "Andrey Borodavka", id: "o0pnHjdwvIcTpIHxNBts4EyZqo23", properties: ["city": "Muhosransk"])
        FirebaseAPI.shared.writeUser(name: "Kosi4chka Lizoblud", id: "L99J98ZxDvSK8gXjUX5P3fplVu12", properties: ["gender": "transgender"])
        FirebaseAPI.shared.addUserGroup(name: "PornHub", id: "o0pnHjdwvIcTpIHxNBts4EyZqo23", properties: ["Members": "∞"])
        FirebaseAPI.shared.addUserGroup(name: "PornHub", id: "L99J98ZxDvSK8gXjUX5P3fplVu12", properties: ["Members": "∞"])
        
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
