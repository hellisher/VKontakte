import Alamofire
import SwiftyJSON
import RealmSwift

class GetVKAPI {
    
    static let sessionRequest: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        let session = Alamofire.Session(configuration: config)
        return session
    }()
    
    //Получение новостей пользователя
    func loadUserNews(completion: @escaping (Result<[News], Error>) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserNews = URLComponents()
        urlUserNews.scheme = "https"
        urlUserNews.host = "api.vk.com"
        urlUserNews.path = "/method/newsfeed.get"
        urlUserNews.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        
        let userNewsDispatchGroup = DispatchGroup()
        
        DispatchQueue.global().async(group: userNewsDispatchGroup) {
            GetVKAPI.sessionRequest.request(urlUserNews, method: .get, parameters: accessParameters).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("Успешный вывод списка новостей: \(json)")
                    let newJSON = json["response"]["profiles"].arrayValue
                    let news = newJSON.map {News($0)}
                    completion(.success(news))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        DispatchQueue.global().async(group: userNewsDispatchGroup) {
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
        
        DispatchQueue.global().async(group: userNewsDispatchGroup) {
            GetVKAPI.sessionRequest.request(urlUserNews, method: .get, parameters: accessParameters).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("Успешный вывод списка новостей: \(json)")
                    let newJSON = json["response"]["groups"].arrayValue
                    let news = newJSON.map {News($0)}
                    completion(.success(news))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        userNewsDispatchGroup.notify(queue: DispatchQueue.main) {
            //Как передать общий completion?
        }
    }
    
    //Получение списка друзей пользователя
    func loadUserFriendsData(completion: @escaping (Result<[Friend], Error>) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserFriends = URLComponents()
        urlUserFriends.scheme = "https"
        urlUserFriends.host = "api.vk.com"
        urlUserFriends.path = "/method/friends.get"
        urlUserFriends.queryItems = [
            URLQueryItem(name: "user_id", value: Session.instance.userID),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "11"),
            URLQueryItem(name: "fields", value: "bdate, city, country, photo_100"),
            URLQueryItem(name: "name_case", value: "nom"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        DispatchQueue.global().async {
            GetVKAPI.sessionRequest.request(urlUserFriends, method: .get, parameters: accessParameters).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("Успешный вывод списка друзей: \(json)")
                    let newJSON = json["response"]["items"].arrayValue
                    let friends = newJSON.compactMap {Friend($0)}
                    completion(.success(friends))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    //Получение фотографий пользователя
    func loadUserPhotosData(completion: @escaping (Result<[AlbumPhoto], Error>) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserPhotos = URLComponents()
        urlUserPhotos.scheme = "https"
        urlUserPhotos.host = "api.vk.com"
        urlUserPhotos.path = "/method/photos.get"
        urlUserPhotos.queryItems = [
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        DispatchQueue.global().async {
            GetVKAPI.sessionRequest.request(urlUserPhotos, method: .get, parameters: accessParameters).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("Успешный вывод списка друзей: \(json)")
                    let newJSON = json["response"]["items"].arrayValue
                    let photos = newJSON.map {AlbumPhoto($0)}
                    completion(.success(photos))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    //Получение групп пользователя
    func loadUserGroupsData(completion: @escaping (Result<[Group], Error>) -> Void) {
        let accessParameters = ["access_token": Session.instance.token]
        var urlUserGroups = URLComponents()
        urlUserGroups.scheme = "https"
        urlUserGroups.host = "api.vk.com"
        urlUserGroups.path = "/method/groups.get"
        urlUserGroups.queryItems = [
            URLQueryItem(name: "user_id", value: Session.instance.userID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        DispatchQueue.global().async {
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
    }
}
