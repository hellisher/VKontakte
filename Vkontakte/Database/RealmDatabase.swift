import Foundation
import RealmSwift

class RealmDatabase {
    
    static let shared = RealmDatabase()
    private init () {}
    
    //Сохранение списка друзей пользователя в Realm
    func saveUserFriendsData(_ friends: [Friend]) {
        do {
            let realm = try Realm()
            let oldFriends = realm.objects(Friend.self)
            try! realm.write {
                realm.delete(oldFriends)
                realm.add(friends)
            }
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    //Загрузка списка друзей пользователя из базы данных Realm
    func loadFriendsData() -> [Friend] {
            let realm = try! Realm()
            let friends = realm.objects(Friend.self)
            return Array(friends)
    }
    
    //Уведомление об изменении списка друзей пользователя в базе данных Realm
    func changesInTheFriendsData() -> NotificationToken? {
        let realm = try! Realm()
        let friends = realm.objects(Friend.self)
        return friends.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let results):
                print(results)
            case let .update(results, deletions, insertions, modifications):
                print(results, deletions, insertions, modifications)
            case .error(let error):
                print(error)
            }
            print("Friend's data has changed")
        }
    }
    
    //Сохранение фотографий пользователя в Realm
    func saveUserPhotosData(_ photos: [UserPhoto]) {
        do {
            let realm = try Realm()
            let oldPhotos = realm.objects(UserPhoto.self)
            try! realm.write {
                realm.delete(oldPhotos)
                realm.add(photos)
            }
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    //Загрузка фотографий пользователя из базы данных Realm
    func loadUserPhotosData() -> [UserPhoto] {
        let realm = try! Realm()
        let photos = realm.objects(UserPhoto.self)
        return Array(photos)
    }
    
    //
    func changesInTheUserPhotosData() -> NotificationToken? {
        let realm = try! Realm()
        let photos = realm.objects(UserPhoto.self)
        return photos.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let results):
                print(results)
            case let .update(results, deletions, insertions, modifications):
                print(results, deletions, insertions, modifications)
            case .error(let error):
                print(error)
            }
            print("User's album data has changed")
        }
    }
    
    //Сохранение списка групп пользователя в Realm
    func saveUserGroupsData(_ groups: [Group]) {
        do {
            let realm = try Realm()
            let oldGroups = realm.objects(Group.self)
            try! realm.write {
                realm.delete(oldGroups)
                realm.add(groups)
            }
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    //Загрузка списка групп пользователя из базы данных Realm
    func loadGroupsData() -> [Group] {
            let realm = try! Realm()
            let groups = realm.objects(Group.self)
            return Array(groups)
    }
    
    //Уведомление об изменении списка групп пользователя в базе данных Realm
    func changesInTheGroupsData() -> NotificationToken? {
        let realm = try! Realm()
        let groups = realm.objects(Group.self)
        return groups.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let results):
                print(results)
            case let .update(results, deletedIndexes, insertedIndexes, modificatedIndexes):
//                deleteInTable(controller: MyGroupsController, indexPath: deletedIndexes.map { IndexPath(row: $0, section: 0)})
//                insertInTable(controller: MyGroupsController, indexPath: insertedIndexes.map { IndexPath(row: $0, section: 0)})
//                updateInTable(controller: MyGroupsController, indexPath: modificatedIndexes.map { IndexPath(row: $0, section: 0)})
                print(results, deletedIndexes, insertedIndexes, modificatedIndexes)
            case .error(let error):
                print(error)
            }
            print("Group's data has changed")
        }
    }
    
    func insertInTable(controller: UITableViewController, indexPath: [IndexPath]) {
        controller.tableView.beginUpdates()
        controller.tableView.insertRows(at: indexPath, with: .none)
        controller.tableView.endUpdates()
    }
    
    func deleteInTable(controller: UITableViewController, indexPath: [IndexPath]) {
        controller.tableView.beginUpdates()
        controller.tableView.deleteRows(at: indexPath, with: .none)
        controller.tableView.endUpdates()
    }
    
    func updateInTable(controller: UITableViewController, indexPath: [IndexPath]) {
        controller.tableView.beginUpdates()
        controller.tableView.reloadRows(at: indexPath, with: .none)
        controller.tableView.endUpdates()
    }
    
}
