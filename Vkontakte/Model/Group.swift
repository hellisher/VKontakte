import RealmSwift
import SwiftyJSON

class Group: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var groupName: String = ""
    @objc dynamic var groupAvatar: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.groupName = json["name"].stringValue
        self.groupAvatar =  json["photo_100"].stringValue
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
