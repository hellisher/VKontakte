import Foundation
import RealmSwift

class Group: Object, Decodable {
    
    @objc dynamic var groupName = ""
    
    enum GroupKeys: String, CodingKey {
        case groupName = "name"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: GroupKeys.self)
        self.groupName = try values.decode(String.self, forKey: .groupName)
    }
}
