import Alamofire
import SwiftyJSON
import RealmSwift

class GetVKAPI {
    
    //Получение списка друзей пользователя
    func loadUserFriendsData(completion: @escaping () -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserFriends = URLComponents()
        urlUserFriends.scheme = "https"
        urlUserFriends.host = "api.vk.com"
        urlUserFriends.path = "/method/friends.get"
        urlUserFriends.queryItems = [
            URLQueryItem(name: "user_id", value: Session.instance.userID),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "fields", value: "bdate, city, country"),
            URLQueryItem(name: "name_case", value: "nom"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        Alamofire.request(urlUserFriends, method: .get, parameters: accessParameters).responseData { response in
            guard let data = response.value else { return }
            let friends = try! JSONDecoder().decode(FriendsResponseContainer.self, from: data).response.items
            RealmDatabase.shared.saveUserFriendsData(friends)
            completion()
            print(friends)
        }
    }
        
    //Получение фотографий пользователя
    func loadUserPhotosData(completion: @escaping () -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserPhotos = URLComponents()
        urlUserPhotos.scheme = "https"
        urlUserPhotos.host = "api.vk.com"
        urlUserPhotos.path = "/method/photos.get"
        urlUserPhotos.queryItems = [
            URLQueryItem(name: "owner_id", value: "-1"),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        Alamofire.request(urlUserPhotos, method: .get, parameters: accessParameters).responseData { response in
            guard let data = response.value else { return }
            let userPhotos = try! JSONDecoder().decode(UserPhotoResponseContainer.self, from: data).response.items[0].sizes
            RealmDatabase.shared.saveUserPhotosData(userPhotos)
            completion()
            print(userPhotos)
        }
    }
    
    //Получение групп пользователя
    func loadUserGroupsData(completion: @escaping () -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserGroups = URLComponents()
        urlUserGroups.scheme = "https"
        urlUserGroups.host = "api.vk.com"
        urlUserGroups.path = "/method/groups.get"
        urlUserGroups.queryItems = [
            URLQueryItem(name: "user_id", value: Session.instance.userID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        Alamofire.request(urlUserGroups, method: .get, parameters: accessParameters).responseData { response in
            guard let data = response.value else { return }
            let groups = try! JSONDecoder().decode(GroupResponseContainer.self, from: data).response.items
            RealmDatabase.shared.saveUserGroupsData(groups)
            completion()
            print(groups)
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
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        Alamofire.request(urlUserGroupsSearch, method: .get, parameters: accessParameters).responseJSON { response in
            print(response.value ?? "")
        }
    }
}
