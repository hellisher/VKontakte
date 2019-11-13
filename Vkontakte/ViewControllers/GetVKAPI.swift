import UIKit
import Alamofire
import WebKit
import SwiftyJSON

class GetVKAPI {
    
    //Получение списка друзей пользователя
    func getUserFriends() {
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
            print(response.error as Any)
            print(String(bytes: data, encoding: .utf8) as Any)
            let friend = try! JSONDecoder().decode(FriendsResponseContainer.self, from: data)
            print(friend)
        }
    }
    
    //Получение данных о друзьях
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
            let friend = try! JSONDecoder().decode(FriendResponse.self, from: data).items
            completion(friend)
        }
    }
    
    //Получение фотографий пользователя
    func getUserPhotos() {
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
        Alamofire.request(urlUserPhotos, method: .get, parameters: accessParameters).responseData { response in
            guard let data = response.value else { return }
            print(response.error as Any)
            print(String(bytes: data, encoding: .utf8) as Any)
            let friendPhoto = try! JSONDecoder().decode(FriendPhotoResponseContainer.self, from: data)
            print(friendPhoto)
        }
    }
    
        //Загрузка фотографий пользователя
    func loadUserFriendsPhotoData(completion: @escaping ([FriendPhoto]) -> Void) {
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
        Alamofire.request(urlUserPhotos, method: .get, parameters: accessParameters).responseData { response in
            guard let data = response.value else { return }
            let friendPhoto = try! JSONDecoder().decode(FriendPhotoURL.self, from: data).sizes
            completion(friendPhoto)
        }
    }
    
    //Получение групп пользователя
    func getUserGroups() {
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
            print(response.error as Any)
            print(String(bytes: data, encoding: .utf8) as Any)
            let group = try! JSONDecoder().decode(GroupResponseContainer.self, from: data)
            print(group)
        }
    }
    
    //Получение данных о группах
    func loadGroupData(completion: @escaping ([Group]) -> Void) {
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
            let group = try! JSONDecoder().decode(GroupResponse.self, from: data).items
            completion(group)
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
