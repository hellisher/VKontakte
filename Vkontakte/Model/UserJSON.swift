//
//  User.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 28.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

//в методичке был тип Object. Зачем он нужен был?

class UserJSON: Decodable {
    dynamic var firstName = ""
    dynamic var lastName = ""
    
    enum Keys: String, CodingKey {
        case firstName
        case lastName
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: Keys.self)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
    }
}

