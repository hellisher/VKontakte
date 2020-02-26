import RealmSwift
import SwiftyJSON

class AlbumPhoto: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.photo = json["url"].stringValue
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
