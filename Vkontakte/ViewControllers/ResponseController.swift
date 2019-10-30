//
//  VkontakteLoginViewController.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 28.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
import SwiftyJSON

class ResponseController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let userInfo = VKApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "oauth.vk.com"
        urlComposer.path = "/authorize"
        urlComposer.queryItems = [
            URLQueryItem(name: "client_id", value: "7152277"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        webView.load(URLRequest(url: urlComposer.url!))
        webView.navigationDelegate = self
    }
}

extension ResponseController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html" else {
                decisionHandler(.allow)
                return
        }
        let params = url.fragment?
            .components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=")}
            .reduce([String: String](), {(result, params) in
                var dict = result
                let key = params[0]
                let value = params[1]
                dict[key] = value
                return dict
            })
        print(params!)
        let token = params?["access_token"] ?? ""
        let userID = params?["user_id"] ?? ""
        Session.instance.token = token
        Session.instance.userID = userID
        print(Session.instance.token)
        print(Session.instance.userID)
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginFormViewController")
        self.present(viewController!, animated: true)
        
        userInfo.getUserFriends()
        userInfo.getUserPhotos()
        userInfo.getUserGroups()
        userInfo.searchUserGroups(text: "Apple")
        
        decisionHandler(.cancel)
    }
}

class VKApi {
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
            URLQueryItem(name: "v", value: "5.102")
        ]
        Alamofire.request(urlUserFriends, method: .get, parameters: accessParameters).responseData { response in
            guard let data = response.value else { return }
            let json = try! JSON(data: data) //Для чего это требуется?
            
            let user = try! JSONDecoder().decode(UserResponse.self, from: data).list
            print(user)
        }
    }
    //Получение данных о друзьях
    func loadUserFriendsData(firstName: String, lastName: String, completion: @escaping ([UserJSON]) -> Void) {
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
            URLQueryItem(name: "v", value: "5.102")
        ]
        Alamofire.request(urlUserFriends, method: .get, parameters: accessParameters).responseData { response in
        guard let data = response.value else { return }
        let user = try! JSONDecoder().decode(UserResponse.self, from: data).list
        completion(user)
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
            URLQueryItem(name: "v", value: "5.102")
        ]
        Alamofire.request(urlUserPhotos, method: .get, parameters: accessParameters).responseJSON { response in
            print(response.value ?? "")
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
            URLQueryItem(name: "v", value: "5.102")
        ]
        Alamofire.request(urlUserGroups, method: .get, parameters: accessParameters).responseJSON { response in
            print(response.value ?? "")
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
            URLQueryItem(name: "v", value: "5.102")
        ]
        Alamofire.request(urlUserGroupsSearch, method: .get, parameters: accessParameters).responseJSON { response in
            print(response.value ?? "")
        }
    }
}
