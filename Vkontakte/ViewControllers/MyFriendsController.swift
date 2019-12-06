//Final
import UIKit
import RealmSwift

class MyFriendsController: UITableViewController {
    
    var friends = [Friend]()
    var api = GetVKAPI()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = RealmDatabase.shared.changesInTheFriendsData()
        
        FirebaseAPI.shared.writeUser(name: "Andrey Borodavka", id: "o0pnHjdwvIcTpIHxNBts4EyZqo23", properties: ["city": "Muhosransk"])
        FirebaseAPI.shared.writeUser(name: "Kosi4chka Lizoblud", id: "L99J98ZxDvSK8gXjUX5P3fplVu12", properties: ["gender": "transgender"])
        FirebaseAPI.shared.addUserGroup(name: "PornHub", id: "o0pnHjdwvIcTpIHxNBts4EyZqo23", properties: ["Members": "∞"])
        FirebaseAPI.shared.addUserGroup(name: "PornHub", id: "L99J98ZxDvSK8gXjUX5P3fplVu12", properties: ["Members": "∞"])
        
        api.loadUserFriendsData() { [weak self] in
            DispatchQueue.main.async {
                self?.friends = RealmDatabase.shared.loadFriendsData()
                self?.tableView.reloadData()
            }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendCell", for: indexPath) as! MyFriendsCell
        let friend = friends[indexPath.row]
        cell.friendName.text = friend.firstName + " " + friend.lastName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyFriendsPhotoViewController") as! MyFriendsPhotoViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
