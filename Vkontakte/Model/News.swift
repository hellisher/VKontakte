import RealmSwift
import SwiftyJSON

class News: Object {
    
    @objc dynamic var sourceId: Int = 0
    @objc dynamic var newsText: String = ""
    @objc dynamic var date: Double = 0
    @objc dynamic var post_id: Int = 0
    @objc dynamic var postPhoto: String = ""
    @objc dynamic var commentsCount: Int = 0
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var userLike: Int = 0
    
    convenience init(_ json: JSON) {
        self.init()
        self.sourceId = json["source_id"].intValue
        self.newsText = json["text"].stringValue
        self.date = json["date"].doubleValue
        self.post_id = json["post_id"].intValue
        self.postPhoto = json["attachments"][0]["photo"]["sizes"][0]["url"].stringValue
        self.commentsCount = json["comments"]["count"].intValue
        self.likesCount = json["likes"]["count"].intValue
        self.userLike = json["likes"]["user_likes"].intValue
    }
}
