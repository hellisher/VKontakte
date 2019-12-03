import Foundation
import RealmSwift

class Friend: Object, Decodable {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    
    enum FriendKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: FriendKeys.self)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
    }
}

