import Foundation
import RealmSwift

class UserPhoto: Object, Decodable {
    @objc dynamic var userPhoto = ""

    enum UserPhotoKeys: String, CodingKey {
        case userPhoto = "url"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: UserPhotoKeys.self)
        self.userPhoto = try values.decode(String.self, forKey: .userPhoto)
    }
}
