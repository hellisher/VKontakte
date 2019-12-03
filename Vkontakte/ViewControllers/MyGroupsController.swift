import UIKit
import RealmSwift

class MyGroupsController: UITableViewController {
    
    var myGroups = [Group]()
    var api = GetVKAPI()
    var token: NotificationToken?
    
    func insertInTable(indexPath: [IndexPath]) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPath, with: .none)
        self.tableView.endUpdates()
    }
    
    func deleteInTable(indexPath: [IndexPath]) {
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: indexPath, with: .none)
        self.tableView.endUpdates()
    }
    
    func updateInTable(indexPath: [IndexPath]) {
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: indexPath, with: .none)
        self.tableView.endUpdates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        token = RealmDatabase.shared.changesInTheGroupsData()
        
        let realm = try! Realm()
        let groups = realm.objects(Group.self)
        token? = groups.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let results):
                print(results)
            case let .update(results, deletedIndexes, insertedIndexes, modificatedIndexes):
                self.insertInTable(indexPath: insertedIndexes.map { IndexPath(row: $0, section: 0)})
                self.deleteInTable(indexPath: deletedIndexes.map { IndexPath(row: $0, section: 0)})
                self.updateInTable(indexPath: modificatedIndexes.map { IndexPath(row: $0, section: 0)})
                print(results, deletedIndexes, insertedIndexes, modificatedIndexes)
            case .error(let error):
                print(error)
            }
            print("Group's data has changed")
        }
        
        api.loadUserGroupsData() { [weak self] in
            DispatchQueue.main.async {
                self?.myGroups = RealmDatabase.shared.loadGroupsData()
                self?.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupsCell
        let group = myGroups[indexPath.row]
        cell.groupName.text = group.groupName
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

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
