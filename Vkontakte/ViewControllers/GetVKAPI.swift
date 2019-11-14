import Alamofire
import SwiftyJSON
import RealmSwift

class GetVKAPI {
    
    //Получение списка друзей пользователя
    func loadUserFriendsData(completion: @escaping ([Friend]) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserFriends = URLComponents()
        urlUserFriends.scheme = "https"
        urlUserFriends.host = "api.vk.com"
        urlUserFriends.path = "/method/friends.get"
        urlUserFriends.queryItems = [
            URLQueryItem(name: "user_id", value: "6492"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "fields", value: "bdate, city, country"),
            URLQueryItem(name: "name_case", value: "nom"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        Alamofire.request(urlUserFriends, method: .get, parameters: accessParameters).responseData { response in
            guard let data = response.value else { return }
            let friends = try! JSONDecoder().decode(FriendsResponseContainer.self, from: data).response.items
            self.saveUserFriendsData(friends)
            completion(friends)
            print(friends)
        }
    }
    
    //Сохранение списка  друзей пользователя в Realm
    func saveUserFriendsData(_ friends: [Friend]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    //Получение фотографий пользователя
    func loadUserPhotosData(completion: @escaping ([UserPhoto]) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserPhotos = URLComponents()
        urlUserPhotos.scheme = "https"
        urlUserPhotos.host = "api.vk.com"
        urlUserPhotos.path = "/method/photos.get"
        urlUserPhotos.queryItems = [
            URLQueryItem(name: "owner_id", value: "-1"),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "count", value: "2"),
            URLQueryItem(name: "v", value: "5.103")
        ]
//        Alamofire.request(urlUserPhotos, method: .get, parameters: accessParameters).responseData { response in
//            guard let data = response.value else { return }
//            let userPhotos = try! JSONDecoder().decode(UserPhotoResponseContainer.self, from: data).response.items.sizes
//            self.saveUserPhotosData(userPhotos)
//            completion(userPhotos)
//            print(userPhotos)
//        }
    }
    
    //Сохранение фотографий пользователя в Realm
    func saveUserPhotosData(_ photos: [UserPhoto]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photos)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    //Получение групп пользователя
    func loadUserGroupsData(completion: @escaping ([Group]) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserGroups = URLComponents()
        urlUserGroups.scheme = "https"
        urlUserGroups.host = "api.vk.com"
        urlUserGroups.path = "/method/groups.get"
        urlUserGroups.queryItems = [
            URLQueryItem(name: "user_id", value: Session.instance.userID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        Alamofire.request(urlUserGroups, method: .get, parameters: accessParameters).responseData { response in
            guard let data = response.value else { return }
            let groups = try! JSONDecoder().decode(GroupResponseContainer.self, from: data).response.items
            self.saveUserGroupsData(groups)
            completion(groups)
            print(groups)
        }
    }
    
    //Сохранение списка групп пользователя в Realm
    func saveUserGroupsData(_ groups: [Group]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    //Поиск групп пользователя
    func searchUserGroups(text: String) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserGroupsSearch = URLComponents()
        urlUserGroupsSearch.scheme = "https"
        urlUserGroupsSearch.host = "api.vk.com"
        urlUserGroupsSearch.path = "/method/groups.search"
        urlUserGroupsSearch.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        Alamofire.request(urlUserGroupsSearch, method: .get, parameters: accessParameters).responseJSON { response in
            print(response.value ?? "")
        }
    }
}
