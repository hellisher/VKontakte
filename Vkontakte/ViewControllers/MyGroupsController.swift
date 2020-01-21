import UIKit
import RealmSwift

class MyGroupsController: UITableViewController {
    
    var myGroups = try? Realm().objects(Group.self).sorted(byKeyPath: "id")
    var requestVKAPI = GetVKAPI()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async {
            self.requestVKAPI.loadUserGroupsData() { [weak self] result in
                guard self != nil else { return }
                switch result {
                case .success(let groups):
                    RealmDatabase.shared.saveUserGroupsData(groups)
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
        return myGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupsCell
        guard let group = myGroups?[indexPath.row] else {return cell}
        cell.configure(with: group)
        return cell
    }
    
    //    @IBAction func addGroup(segue: UIStoryboardSegue) {
    //        if segue.identifier == "addGroup" {
    //            let allGroupsController = segue.source as! AllGroupsController
    //            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
    //                let group = allGroupsController.allGroups[indexPath.row]
    //                for grp in myGroups {
    //                    if grp.groupName == group.groupName {
    //                        return
    //                    }
    //                }
    //                myGroups.append(group)
    //                tableView.reloadData()
    //            }
    //        }
    //    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            myGroups.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        }
    //    }
}
