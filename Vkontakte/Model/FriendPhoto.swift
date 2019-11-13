//
//  Photo.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 28.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation

class FriendPhoto: Decodable {
<<<<<<< HEAD
    dynamic var friendPhoto: Int = 0
=======
    dynamic var friendPhoto = ""
>>>>>>> Lesson-3

    enum FriendPhotoKeys: String, CodingKey {
        case friendPhoto = "url"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: FriendPhotoKeys.self)
        self.friendPhoto = try values.decode(String.self, forKey: .friendPhoto)
    }
}
