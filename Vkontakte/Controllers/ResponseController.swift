import UIKit
import Alamofire
import WebKit
import SwiftyJSON

class ResponseController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let userInfo = GetVKAPI()
    
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
            URLQueryItem(name: "scope", value: "wall, friends, groups, video, offline"),
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
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
        self.present(viewController!, animated: true)
        
        decisionHandler(.cancel)
    }
}
