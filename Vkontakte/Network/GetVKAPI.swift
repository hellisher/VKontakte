import Alamofire
import SwiftyJSON
import RealmSwift

class GetVKAPI {
    
    static let sessionRequest: SessionManager = {
        let config = URLSessionConfiguration.default
        let session = SessionManager(configuration: config)
        return session
    }()
    
    //Получение новостей пользователя
    func loadUserNews(completion: @escaping (Result<[News]>) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserNews = URLComponents()
        urlUserNews.scheme = "https"
        urlUserNews.host = "api.vk.com"
        urlUserNews.path = "/method/newsfeed.get"
        urlUserNews.queryItems = [
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        
        GetVKAPI.sessionRequest.request(urlUserNews, method: .get, parameters: accessParameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Успешный вывод списка новостей: \(json)")
                let newJSON = json["response"]["items"].arrayValue
                let news = newJSON.map {News($0)}
                completion(.success(news))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //Получение списка друзей пользователя
    func loadUserFriendsData(completion: @escaping (Result<[Friend]>) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserFriends = URLComponents()
        urlUserFriends.scheme = "https"
        urlUserFriends.host = "api.vk.com"
        urlUserFriends.path = "/method/friends.get"
        urlUserFriends.queryItems = [
            URLQueryItem(name: "user_id", value: Session.instance.userID),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "fields", value: "bdate, city, country, photo_100"),
            URLQueryItem(name: "name_case", value: "nom"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        
        GetVKAPI.sessionRequest.request(urlUserFriends, method: .get, parameters: accessParameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Успешный вывод списка друзей: \(json)")
                let newJSON = json["response"]["items"].arrayValue
                let news = newJSON.map {Friend($0)}
                completion(.success(news))
            case .failure(let error):
                completion(.failure(error))
            }
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
    func loadUserGroupsData(completion: @escaping (Result<[Group]>) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserGroups = URLComponents()
        urlUserGroups.scheme = "https"
        urlUserGroups.host = "api.vk.com"
        urlUserGroups.path = "/method/groups.get"
        urlUserGroups.queryItems = [
            URLQueryItem(name: "user_id", value: Session.instance.userID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "15"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        
        GetVKAPI.sessionRequest.request(urlUserGroups, method: .get, parameters: accessParameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Успешный вывод списка групп пользователя: \(json)")
                let newJSON = json["response"]["items"].arrayValue
                let group = newJSON.map {Group($0)}
                completion(.success(group))
            case .failure(let error):
                completion(.failure(error))
            }
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
