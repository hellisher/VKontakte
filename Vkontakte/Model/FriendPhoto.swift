//
//  Photo.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 28.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import UIKit

//ВОПРОС! Не понимаю как прописать в классе декодирование полученной фотографии. Прошу подсказать.

class FriendPhoto: Decodable {
    dynamic var friendPhoto = UIImage()

    enum FriendPhotoKeys: UIImage, CodingKey {
        case friendPhoto
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: FriendPhotoKeys.self)
        self.friendPhoto = try values.decode(UIImage.self, forKey: .friendPhoto)
    }
}
