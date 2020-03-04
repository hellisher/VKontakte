import RealmSwift
import SwiftyJSON

class Friend: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatar: String = ""
    
    convenience init?(_ json: JSON) {
        if json["first_name"].stringValue == "DELETED" {
            return nil
        } else {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.avatar =  json["photo_100"].stringValue
        }
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
